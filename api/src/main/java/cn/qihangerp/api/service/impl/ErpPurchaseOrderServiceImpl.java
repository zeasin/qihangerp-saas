package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.utils.DateUtils;
import cn.qihangerp.api.domain.*;
import cn.qihangerp.api.domain.bo.PurchaseOrderAddBo;
import cn.qihangerp.api.domain.bo.PurchaseOrderOptionBo;
import cn.qihangerp.api.mapper.*;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.service.ErpPurchaseOrderService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
* @author qilip
* @description 针对表【erp_purchase_order(采购订单)】的数据库操作Service实现
* @createDate 2024-04-21 20:27:10
*/
@AllArgsConstructor
@Service
public class ErpPurchaseOrderServiceImpl extends ServiceImpl<ErpPurchaseOrderMapper, ErpPurchaseOrder>
    implements ErpPurchaseOrderService{
    private final ErpPurchaseOrderMapper mapper;
    private final ErpPurchaseOrderItemMapper itemMapper;
    private final ErpPurchaseOrderShipMapper shipMapper;
    private final ErpPurchaseOrderPayableMapper payableMapper;
    private final ErpSupplierMapper supplierMapper;

    @Override
    public PageResult<ErpPurchaseOrder> queryPageList(ErpPurchaseOrder bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpPurchaseOrder> queryWrapper = new LambdaQueryWrapper<ErpPurchaseOrder>()
                .eq(ErpPurchaseOrder::getTenantId,bo.getTenantId())
                .eq(bo.getSupplierId()!=null,ErpPurchaseOrder::getSupplierId,bo.getSupplierId())
                .eq(org.springframework.util.StringUtils.hasText(bo.getOrderNo()),ErpPurchaseOrder::getOrderNo,bo.getOrderNo())
//                .eq(org.springframework.util.StringUtils.hasText(bo.getReceiverName()),ErpOrder::getReceiverName,bo.getReceiverName())
//                .like(org.springframework.util.StringUtils.hasText(bo.getReceiverMobile()),ErpOrder::getReceiverMobile,bo.getReceiverMobile())
                ;
        Page<ErpPurchaseOrder> pages = mapper.selectPage(pageQuery.build(), queryWrapper);

        return PageResult.build(pages);
    }

    @Transactional
    @Override
    public int insertScmPurchaseOrder(PurchaseOrderAddBo addBo)
    {
        if(addBo.getGoodsList() == null || addBo.getGoodsList().isEmpty()) return -1;
        // 添加主表
        ErpPurchaseOrder ord = new ErpPurchaseOrder();
        ord.setOrderNo("PUR"+ DateUtils.parseDateToStr("yyyyMMddHHmmss",new Date()));
        ord.setTenantId(addBo.getTenantId());
        ord.setOrderAmount(addBo.getOrderAmount());
        ord.setCreateTime(DateUtils.getNowDate());
        ord.setOrderDate(addBo.getOrderDate());
        ord.setSupplierId(addBo.getSupplierId().toString());
        ord.setOrderTime(System.currentTimeMillis()/1000);
        ord.setCreateBy(addBo.getCreateBy());
        ord.setStatus(0);
        ord.setShipAmount(BigDecimal.ZERO);
        mapper.insert(ord);

        // 添加子表
        for (var item:addBo.getGoodsList()) {
            ErpPurchaseOrderItem orderItem = new ErpPurchaseOrderItem();
            orderItem.setOrderDate(addBo.getOrderDate());
            orderItem.setTenantId(ord.getTenantId());
            orderItem.setSupplierId(ord.getSupplierId());
            orderItem.setOrderId(Long.parseLong(ord.getId()));
            orderItem.setOrderNo(ord.getOrderNo());
            orderItem.setAmount(item.getAmount().doubleValue());
            orderItem.setGoodsId(item.getGoodsId());
            orderItem.setGoodsNum(item.getNumber());
            orderItem.setIsDelete(0);
            orderItem.setPrice(item.getPurPrice());
            orderItem.setQuantity(item.getQty());
            orderItem.setSpecId(item.getId());
            orderItem.setSpecNum(item.getSpecNum());
            orderItem.setStatus(0);
            orderItem.setTransType("Purchase");
            orderItem.setGoodsName(item.getName());
            orderItem.setColorValue(item.getColorValue());
            orderItem.setColorImage(item.getColorImage());
            orderItem.setSizeValue(item.getSizeValue());
            orderItem.setStyleValue(item.getStyleValue());

            itemMapper.insert(orderItem);
        }
        return 1;
    }


    @Transactional
    @Override
    public int updateScmPurchaseOrder(PurchaseOrderOptionBo bo)
    {
        ErpPurchaseOrder order = mapper.selectById(bo.getId());
        if(order == null) return -1;

        if(bo.getOptionType().equals("audit")){
            if(order.getStatus() !=0){
                // 状态不是待审核的
                return -1;
            }
            ErpPurchaseOrder scmPurchaseOrder = new ErpPurchaseOrder();
            scmPurchaseOrder.setId(order.getId());
            scmPurchaseOrder.setUpdateBy(bo.getUpdateBy());
            scmPurchaseOrder.setUpdateTime(DateUtils.getNowDate());
            scmPurchaseOrder.setAuditUser(bo.getAuditUser());
            scmPurchaseOrder.setAuditTime(System.currentTimeMillis()/1000);
            scmPurchaseOrder.setRemark(bo.getRemark());
            scmPurchaseOrder.setStatus(1);
            return mapper.updateById(scmPurchaseOrder);
        }else if (bo.getOptionType().equals("confirm")) {
            if(order.getStatus() !=1){
                // 状态不是已审核的不能确认
                return -1;
            }
//            // 查询数据
//            ScmPurchaseOrderItem oi = new ScmPurchaseOrderItem();
//            oi.setOrderId(order.getId());
//            List<ScmPurchaseOrderItem> items = scmPurchaseOrderItemMapper.selectScmPurchaseOrderItemList(oi);
//            Map<Long, List<ScmPurchaseOrderItem>> goodsGroup = items.stream().collect(Collectors.groupingBy(x -> x.getGoodsId()));
//            Long total = items.stream().mapToLong(ScmPurchaseOrderItem::getQuantity).sum();
//            // 生成费用信息
//            ScmPurchaseOrderCost cost = new ScmPurchaseOrderCost();
//            cost.setId(order.getId());
//            cost.setOrderNo(order.getOrderNo());
//            cost.setOrderDate(order.getOrderDate());
//            cost.setOrderGoodsUnit(goodsGroup.size());
//            cost.setOrderSpecUnit(items.size());
//            cost.setOrderSpecUnitTotal(total);
//            cost.setOrderAmount(order.getOrderAmount());
//            cost.setActualAmount(bo.getTotalAmount());
//            cost.setFreight(BigDecimal.ZERO);
//            cost.setConfirmUser(bo.getConfirmUser());
//            cost.setConfirmTime(new Date());
//            cost.setCreateBy(bo.getUpdateBy());
//            cost.setPayAmount(BigDecimal.ZERO);
//            cost.setPayCount(0L);
//            cost.setStatus(0L);
//            costMapper.insertScmPurchaseOrderCost(cost);

            // 更新主表
            ErpPurchaseOrder scmPurchaseOrder = new ErpPurchaseOrder();
            scmPurchaseOrder.setId(order.getId());
            scmPurchaseOrder.setUpdateBy(bo.getUpdateBy());
            scmPurchaseOrder.setUpdateTime(DateUtils.getNowDate());
            scmPurchaseOrder.setStatus(101);
            scmPurchaseOrder.setSupplierConfirmTime(new Date());
            mapper.updateById(scmPurchaseOrder);
        }
        else if (bo.getOptionType().equals("SupplierShip")) {
            if(order.getStatus() !=101){
                // 状态不是已确认的不能发货
                return -1;
            }
            // 查询数据
            List<ErpPurchaseOrderItem> items = itemMapper.selectList(new LambdaQueryWrapper<ErpPurchaseOrderItem>().eq(ErpPurchaseOrderItem::getOrderId,order.getId()));
            Map<Long, List<ErpPurchaseOrderItem>> goodsGroup = items.stream().collect(Collectors.groupingBy(x -> x.getGoodsId()));
            Long total = items.stream().mapToLong(ErpPurchaseOrderItem::getQuantity).sum();

            // 生成物流信息
            ErpPurchaseOrderShip ship = new ErpPurchaseOrderShip();
//            ship.setId(Long.parseLong(order.getId()));
            ship.setOrderId(order.getId());
            ship.setTenantId(order.getTenantId());
            ship.setSupplierId(order.getSupplierId());
            ship.setOrderNo(order.getOrderNo());
            ship.setOrderDate(order.getOrderDate());
            ship.setOrderGoodsUnit(goodsGroup.size());
            ship.setOrderSpecUnit(items.size());
            ship.setOrderSpecUnitTotal(total);
            ship.setShipCompany(bo.getShipCompany());
            ship.setShipNo(bo.getShipNo());
            ship.setFreight(bo.getShipCost());
            ship.setShipTime(bo.getSupplierDeliveryTime());
            ship.setCreateBy(bo.getUpdateBy());
            ship.setCreateTime(new Date());
            ship.setStatus(0);
            ship.setBackCount(0);
            ship.setStockInCount(0);
            shipMapper.insert(ship);
//            // 更新费用表
//            ScmPurchaseOrderCost cost = new ScmPurchaseOrderCost();
//            cost.setId(order.getId());
//            cost.setFreight(bo.getShipCost());
//            costMapper.updateScmPurchaseOrderCost(cost);

            //TODO:待完善
            ErpSupplier scmSupplier = supplierMapper.selectById(order.getSupplierId());
            // 生成应付信息fms_payable_purchase
            ErpPurchaseOrderPayable fmsPP = new ErpPurchaseOrderPayable();
            fmsPP.setTenantId(order.getTenantId());
            fmsPP.setSupplierId(order.getSupplierId());
            fmsPP.setSupplierName(scmSupplier!=null ? scmSupplier.getName():"数据库未找到供应商信息");
            fmsPP.setAmount(order.getOrderAmount().add(bo.getShipCost()));
            fmsPP.setDate(new Date());
            fmsPP.setPurchaseOrderNo(order.getOrderNo());
            fmsPP.setPurchaseDesc("{采购商品总数量:"+total+",不同款式:"+goodsGroup.size()+",不同SKU:"+items.size()+",商品总价:"+order.getOrderAmount()+",运费:"+bo.getShipCost()+"}");
            fmsPP.setStatus(0);
            fmsPP.setCreateTime(new Date());
            fmsPP.setCreateBy(bo.getUpdateBy());
            payableMapper.insert(fmsPP);

            // 更新主表
            ErpPurchaseOrder scmPurchaseOrder = new ErpPurchaseOrder();
            scmPurchaseOrder.setId(order.getId());
            scmPurchaseOrder.setUpdateBy(bo.getUpdateBy());
            scmPurchaseOrder.setUpdateTime(DateUtils.getNowDate());
            scmPurchaseOrder.setStatus(102);
            scmPurchaseOrder.setSupplierDeliveryTime(new Date());
            scmPurchaseOrder.setShipAmount(bo.getShipCost());
            mapper.updateById(scmPurchaseOrder);
        }
        return 1;
    }


}




