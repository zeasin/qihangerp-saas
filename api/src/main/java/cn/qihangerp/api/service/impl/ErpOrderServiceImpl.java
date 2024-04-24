package cn.qihangerp.api.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.transaction.annotation.Transactional;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.common.ResultVoEnum;
import cn.qihangerp.api.common.bo.ErpOrderShipBo;
import cn.qihangerp.api.domain.ErpOrder;
import cn.qihangerp.api.domain.ErpOrderItem;
import cn.qihangerp.api.mapper.ErpOrderItemMapper;
import cn.qihangerp.api.service.ErpOrderService;
import cn.qihangerp.api.mapper.ErpOrderMapper;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
* @author TW
* @description 针对表【erp_order(订单表)】的数据库操作Service实现
* @createDate 2024-04-03 15:57:41
*/
@AllArgsConstructor
@Service
public class ErpOrderServiceImpl extends ServiceImpl<ErpOrderMapper, ErpOrder>
    implements ErpOrderService{
    private final ErpOrderMapper mapper;
    private final ErpOrderItemMapper orderItemMapper;
    @Override
    public PageResult<ErpOrder> queryPageList(ErpOrder bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpOrder> queryWrapper = new LambdaQueryWrapper<ErpOrder>()
                .eq(ErpOrder::getTenantId,bo.getTenantId())
                .eq(bo.getShopId()!=null,ErpOrder::getShopId,bo.getShopId())
                .eq(org.springframework.util.StringUtils.hasText(bo.getOrderNum()),ErpOrder::getOrderNum,bo.getOrderNum())
                .eq(org.springframework.util.StringUtils.hasText(bo.getShippingNumber()),ErpOrder::getShippingNumber,bo.getShippingNumber())
                .eq(org.springframework.util.StringUtils.hasText(bo.getReceiverName()),ErpOrder::getReceiverName,bo.getReceiverName())
                .like(org.springframework.util.StringUtils.hasText(bo.getReceiverMobile()),ErpOrder::getReceiverMobile,bo.getReceiverMobile())
                ;
        Page<ErpOrder> pages = mapper.selectPage(pageQuery.build(), queryWrapper);

        // 查询子订单
        if(pages.getRecords()!=null){
            for (var order:pages.getRecords()) {
                order.setItemList(orderItemMapper.selectList(new LambdaQueryWrapper<ErpOrderItem>().eq(ErpOrderItem::getOrderId, order.getId())));
            }
        }

        return PageResult.build(pages);
    }

    @Transactional
    @Override
    public ResultVo<Integer> shipErpOrder(ErpOrderShipBo shipBo) {
        if(shipBo.getOrderIds()==null||shipBo.getOrderIds().length==0) return ResultVo.error(ResultVoEnum.ParamsError,"请选择订单");
        if(shipBo.getShipType()==null) return ResultVo.error(ResultVoEnum.ParamsError,"请指定发货方式");
        for(String orderId:shipBo.getOrderIds()){
            ErpOrder erpOrder = mapper.selectById(orderId);
            if(erpOrder!=null){
                if(erpOrder.getOrderStatus()==0){
                    // 更新状态、发货方式
                    ErpOrder update = new ErpOrder();
                    update.setId(erpOrder.getId());
                    update.setShipType(shipBo.getShipType());
                    update.setOrderStatus(1);
                    update.setUpdateTime(new Date());
                    update.setUpdateBy("确认发货方式");
                    mapper.updateById(update);
                }
            }
        }
        return ResultVo.success();
    }
}




