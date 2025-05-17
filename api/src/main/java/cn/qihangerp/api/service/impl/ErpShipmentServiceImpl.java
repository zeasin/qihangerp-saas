package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.common.utils.DateUtils;
import cn.qihangerp.api.domain.*;
import cn.qihangerp.api.mapper.*;
import cn.qihangerp.api.request.SupplierAgentShipmentRequest;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.service.ErpShipmentService;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
* @author TW
* @description 针对表【erp_order_shipping(发货记录表)】的数据库操作Service实现
* @createDate 2024-04-03 15:57:41
*/
@AllArgsConstructor
@Service
public class ErpShipmentServiceImpl extends ServiceImpl<ErpShipmentMapper, ErpShipment>
    implements ErpShipmentService {
    private final ErpShipmentMapper mapper;
    private final ErpShipmentItemMapper shipmentItemMapper;
    private final ErpOrderMapper orderMapper;
    private final ErpOrderItemMapper orderItemMapper;
    private final ErpLogisticsCompanyMapper erpLogisticsCompanyMapper;

    @Override
    public PageResult<ErpShipment> queryPageList(ErpShipment shipping, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpShipment> queryWrapper = new LambdaQueryWrapper<ErpShipment>()
                .eq(shipping.getShipper()!=null,ErpShipment::getShipper,shipping.getShipper())
                .eq(ErpShipment::getTenantId,shipping.getTenantId())
                .eq(StringUtils.hasText(shipping.getOrderNum()), ErpShipment::getOrderNum, shipping.getOrderNum())
                .eq(StringUtils.hasText(shipping.getShipCode()), ErpShipment::getShipCode, shipping.getShipCode())
                .eq(shipping.getShopId() != null, ErpShipment::getShopId, shipping.getShopId());

        Page<ErpShipment> pages = mapper.selectPage(pageQuery.build(), queryWrapper);
        if(pages.getRecords().size()>0){
            for(ErpShipment item : pages.getRecords()){
                item.setItemList(shipmentItemMapper.selectList(new LambdaQueryWrapper<ErpShipmentItem>().eq(ErpShipmentItem::getShipmentId,item.getId())));
            }
        }
        return PageResult.build(pages);
    }

    @Override
    public ErpShipment queryDetailById(Long id) {
        ErpShipment erpShipment = mapper.selectById(id);
        if(erpShipment!=null){
            erpShipment.setItemList(shipmentItemMapper.selectList(new LambdaQueryWrapper<ErpShipmentItem>().eq(ErpShipmentItem::getShipmentId,erpShipment.getId())));
        }
        return erpShipment;
    }

    @Transactional
    @Override
    public ResultVo<Integer> supplierAgentShipment(SupplierAgentShipmentRequest shipping) {
        // 查询店铺订单是否存在
        ErpShipment erpShipment = mapper.selectById(shipping.shipmentId());
        if(erpShipment==null){
            return ResultVo.error("供应商发货订单不存在!");
        }
        if(erpShipment.getShipper().intValue()!=1){
            return ResultVo.error("不是供应商发货订单！无法操作！");
        }
        if(erpShipment.getShipStatus().intValue()!=0){
            return ResultVo.error("已经发货！无需操作！");
        }
        List<ErpShipmentItem> erpShipmentItems = shipmentItemMapper.selectList(new LambdaQueryWrapper<ErpShipmentItem>().eq(ErpShipmentItem::getShipmentId, erpShipment.getId()));
        if(erpShipmentItems==null||erpShipmentItems.size()==0){
            return ResultVo.error("供应商发货明细数据错误！");
        }
        ErpLogisticsCompany erpLogisticsCompany = erpLogisticsCompanyMapper.selectById(shipping.shipCompanyId());
        if(erpLogisticsCompany==null) return ResultVo.error("快递公司选择错误");
        // 更新明细
        for(ErpShipmentItem erpShipmentItem : erpShipmentItems){
            ErpShipmentItem itemUp = new ErpShipmentItem();
            itemUp.setId(erpShipmentItem.getId());
            itemUp.setStockStatus(2);
            itemUp.setUpdateBy("手动填写供应商发货信息");
            itemUp.setUpdateTime(new Date());
            shipmentItemMapper.updateById(itemUp);
            // 更新 orderItem 发货状态
            ErpOrderItem orderItemUpdate = new ErpOrderItem();
            orderItemUpdate.setId( erpShipmentItem.getOrderItemId());
            orderItemUpdate.setUpdateBy("手动填写供应商发货信息");
            orderItemUpdate.setUpdateTime(new Date());
            orderItemUpdate.setShipStatus(1);//发货状态 0 待发货 1 已发货
            orderItemMapper.updateById(orderItemUpdate);
        }

        // 更新发货订单
        ErpShipment update = new ErpShipment();
        update.setId(erpShipment.getId());
        update.setShipStatus(1);
        update.setShipCompany(erpLogisticsCompany.getName());
        update.setShipCompanyCode(erpLogisticsCompany.getCode());
        update.setShipCode(shipping.shipNo());
        update.setShipTime(DateUtils.parseDate(shipping.shipTime()));
        update.setUpdateTime(new Date());
        update.setUpdateBy("手动填写供应商发货信息");
        mapper.updateById(update);

        //
        // 回写order状态 ====ship_status发货状态 0 待发货 1 部分发货 2全部发货
        long waitShipCount = orderItemMapper.selectList(new LambdaQueryWrapper<ErpOrderItem>().eq(ErpOrderItem::getOrderId, erpShipment.getOrderId()).eq(ErpOrderItem::getShipStatus, 0)).stream().count();

        ErpOrder orderUpdate = new ErpOrder();
        orderUpdate.setId(erpShipment.getOrderId());
        if(waitShipCount==0){
            // 全部发货了
            orderUpdate.setOrderStatus(2);//2已发货
            orderUpdate.setShipStatus(2);
        }else{
            // 部分发货了
            orderUpdate.setShipStatus(1);
        }
        orderUpdate.setUpdateTime(new Date());
        orderUpdate.setUpdateBy("手动填写供应商发货信息");
        orderMapper.updateById(orderUpdate);

        return ResultVo.success();
    }
}




