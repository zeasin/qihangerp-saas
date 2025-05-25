package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.common.utils.DateUtils;
import cn.qihangerp.api.domain.*;
import cn.qihangerp.api.mapper.*;
import cn.qihangerp.api.request.SupplierAgentShipmentRequest;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.service.ErpOrderShipListService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
* @author qilip
* @description 针对表【erp_order_ship_list(发货-备货表（取号发货加入备货清单、分配供应商发货加入备货清单）)】的数据库操作Service实现
* @createDate 2025-05-24 18:52:58
*/
@AllArgsConstructor
@Service
public class ErpOrderShipListServiceImpl extends ServiceImpl<ErpOrderShipListMapper, ErpOrderShipList>
    implements ErpOrderShipListService{
    private final ErpOrderShipListItemMapper shipListItemMapper;
    private final ErpLogisticsCompanyMapper erpLogisticsCompanyMapper;
    private final ErpShipmentMapper erpShipmentMapper;
    private final ErpShipmentItemMapper erpShipmentItemMapper;
    private final ErpOrderItemMapper erpOrderItemMapper;
    private final ErpOrderMapper erpOrderMapper;

    @Override
    public PageResult<ErpOrderShipList> queryPageList(ErpOrderShipList shipping, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpOrderShipList> queryWrapper = new LambdaQueryWrapper<ErpOrderShipList>()
                .eq(shipping.getShipper()!=null,ErpOrderShipList::getShipper,shipping.getShipper())
                .eq(ErpOrderShipList::getTenantId,shipping.getTenantId())
                .eq(StringUtils.hasText(shipping.getOrderNum()), ErpOrderShipList::getOrderNum, shipping.getOrderNum())
                .eq(StringUtils.hasText(shipping.getShipLogisticsCode()), ErpOrderShipList::getShipLogisticsCode, shipping.getShipLogisticsCode())
                .eq(shipping.getShopId() != null, ErpOrderShipList::getShopId, shipping.getShopId());

        Page<ErpOrderShipList> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);
        if(pages.getRecords().size()>0){
            for(ErpOrderShipList item : pages.getRecords()){
                item.setItems(shipListItemMapper.selectList(new LambdaQueryWrapper<ErpOrderShipListItem>().eq(ErpOrderShipListItem::getListId,item.getId())));
            }
        }
        return PageResult.build(pages);
    }

    @Override
    public ErpOrderShipList queryDetailById(Long id) {
        ErpOrderShipList erpOrderShipList = this.baseMapper.selectById(id);
        if(erpOrderShipList==null){
            return null;
        }
        erpOrderShipList.setItems(shipListItemMapper.selectList(new LambdaQueryWrapper<ErpOrderShipListItem>().eq(ErpOrderShipListItem::getListId,erpOrderShipList.getId())));
        return erpOrderShipList;
    }

    @Transactional
    @Override
    public ResultVo<String> supplierAgentShipment(SupplierAgentShipmentRequest shipping) {
        // 查询店铺订单是否存在
        ErpOrderShipList erpShipment = this.baseMapper.selectById(shipping.id());
        if(erpShipment==null){
            return ResultVo.error("供应商发货订单不存在!");
        }
        if(erpShipment.getShipper().intValue()!=1){
            return ResultVo.error("不是供应商发货订单！无法操作！");
        }
        if(erpShipment.getShipStatus().intValue()!=1){
            return ResultVo.error("已经发货！无需操作！");
        }
        List<ErpOrderShipListItem> erpShipmentItems = shipListItemMapper.selectList(
                new LambdaQueryWrapper<ErpOrderShipListItem>()
                        .eq(ErpOrderShipListItem::getListId, erpShipment.getId()));

        if(erpShipmentItems==null||erpShipmentItems.size()==0){
            return ResultVo.error("供应商发货明细数据错误！");
        }
        ErpLogisticsCompany erpLogisticsCompany = erpLogisticsCompanyMapper.selectById(shipping.shipCompanyId());
        if(erpLogisticsCompany==null) return ResultVo.error("快递公司选择错误");
        // 添加发货记录
        // 添加发货记录
        ErpShipment erpShipmentInsert = new ErpShipment();
        erpShipmentInsert.setShipper(1);//发货方 0 仓库发货 1 供应商发货】
        erpShipmentInsert.setTenantId(erpShipment.getTenantId());
        erpShipmentInsert.setShopId(erpShipment.getShopId());
        erpShipmentInsert.setShopType(erpShipment.getShopType());
        erpShipmentInsert.setOrderId(erpShipment.getOrderId().toString());
        erpShipmentInsert.setOrderNum(erpShipment.getOrderNum());
//        erpShipmentInsert.setOrderTime(erpOrder.getOrderTime());
        erpShipmentInsert.setShipType(1);//发货类型（1订单发货2商品补发3商品换货）
        erpShipmentInsert.setShipCompany(erpLogisticsCompany.getName());
        erpShipmentInsert.setShipCompanyCode(erpLogisticsCompany.getCode());
        erpShipmentInsert.setShipCode(shipping.shipNo());
        erpShipmentInsert.setShipFee(BigDecimal.ZERO);
        erpShipmentInsert.setShipTime(new Date());
        erpShipmentInsert.setShipOperator("");
        erpShipmentInsert.setShipStatus(1);//物流状态（0 待发货1已发货2已完成）

        erpShipmentInsert.setPackageHeight(0.0);
        erpShipmentInsert.setPackageWeight(0.0);
        erpShipmentInsert.setPackageLength(0.0);
        erpShipmentInsert.setPackageWidth(0.0);
        erpShipmentInsert.setPacksgeOperator("");
//        erpShipment.setPackages(JSONObject.toJSONString(oOrderItems));
        erpShipmentInsert.setRemark("");
        erpShipmentInsert.setCreateBy("");
        erpShipmentInsert.setCreateTime(new Date());

        erpShipmentMapper.insert(erpShipmentInsert);

        // 更新明细
        for(ErpOrderShipListItem item : erpShipmentItems){
            // 添加发货明细
            ErpShipmentItem erpShipmentItem = new ErpShipmentItem();
            erpShipmentItem.setShipper(erpShipment.getShipper());
            erpShipmentItem.setTenantId(erpShipment.getTenantId());
            erpShipmentItem.setShopId(erpShipment.getShopId());
            erpShipmentItem.setShopType(erpShipment.getShopType());
            erpShipmentItem.setShipmentId(erpShipment.getId());
            erpShipmentItem.setOrderId(erpShipment.getOrderId().toString());
            erpShipmentItem.setOrderNum(erpShipment.getOrderNum());
//            erpShipmentItem.setOrderTime(erpShipment.getOrderTime());
            erpShipmentItem.setOrderItemId(item.getOrderItemId());
            erpShipmentItem.setErpGoodsId(item.getGoodsId());
            erpShipmentItem.setErpSkuId(item.getSkuId());
            erpShipmentItem.setGoodsTitle(item.getGoodsTitle());
            erpShipmentItem.setGoodsNum(item.getGoodsNum());
            erpShipmentItem.setGoodsImg(item.getGoodsImg());
            erpShipmentItem.setGoodsSpec(item.getSkuName());
            erpShipmentItem.setSkuNum(item.getSkuNum());
            erpShipmentItem.setQuantity(item.getQuantity());
            erpShipmentItem.setRemark("");
            erpShipmentItem.setStockStatus(1);
            erpShipmentItem.setCreateBy("");
            erpShipmentItem.setCreateTime(new Date());
            erpShipmentItemMapper.insert(erpShipmentItem);

            ErpOrderShipListItem itemUp = new ErpOrderShipListItem();
            itemUp.setId(item.getId());
            itemUp.setStatus(3);
            itemUp.setUpdateBy("手动填写供应商发货信息");
            itemUp.setUpdateTime(new Date());
            shipListItemMapper.updateById(itemUp);

            // 更新 orderItem 发货状态
            ErpOrderItem orderItemUpdate = new ErpOrderItem();
            orderItemUpdate.setId(item.getOrderItemId());
            orderItemUpdate.setUpdateBy("手动填写供应商发货信息");
            orderItemUpdate.setUpdateTime(new Date());
            orderItemUpdate.setShipStatus(1);//发货状态 0 待发货 1 已发货
            erpOrderItemMapper.updateById(orderItemUpdate);
        }

        // 更新发货订单
        ErpOrderShipList update = new ErpOrderShipList();
        update.setId(erpShipment.getId());
        update.setShipStatus(1);
        update.setShipLogisticsCompany(erpLogisticsCompany.getName());
        update.setShipLogisticsCompanyCode(erpLogisticsCompany.getCode());
        update.setShipLogisticsCode(shipping.shipNo());
        update.setShipStatus(2);
        update.setStatus(3);
        update.setUpdateTime(new Date());
        update.setUpdateBy("手动填写供应商发货信息");
        this.baseMapper.updateById(update);

        //
        // 回写order状态 ====ship_status发货状态 0 待发货 1 部分发货 2全部发货
        long waitShipCount = erpOrderItemMapper.selectList(
                new LambdaQueryWrapper<ErpOrderItem>()
                .eq(ErpOrderItem::getOrderId, erpShipment.getOrderId()).eq(ErpOrderItem::getShipStatus, 0)).stream().count();

        ErpOrder orderUpdate = new ErpOrder();
        orderUpdate.setId(erpShipment.getOrderId().toString());
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
        erpOrderMapper.updateById(orderUpdate);

        return ResultVo.success(erpShipment.getOrderNum());
    }
}




