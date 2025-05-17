package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.domain.*;
import cn.qihangerp.api.domain.vo.SalesDailyVo;
import cn.qihangerp.api.mapper.*;
import cn.qihangerp.api.request.OrderSearchRequest;
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
import cn.qihangerp.api.service.ErpOrderService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
    private final ErpShipmentMapper shipmentMapper;
    private final ErpShipmentItemMapper shipmentItemMapper;
    private final ErpLogisticsCompanyMapper erpLogisticsCompanyMapper;
    private final ErpGoodsSkuMapper erpGoodsSkuMapper;
    private final ErpGoodsMapper erpGoodsMapper;
    private final ErpSupplierMapper erpSupplierMapper;

    private final String DATE_PATTERN =
            "^(?:(?:(?:\\d{4}-(?:0?[1-9]|1[0-2])-(?:0?[1-9]|1\\d|2[0-8]))|(?:(?:(?:\\d{2}(?:0[48]|[2468][048]|[13579][26])|(?:(?:0[48]|[2468][048]|[13579][26])00))-0?2-29))$)|(?:(?:(?:\\d{4}-(?:0?[13578]|1[02]))-(?:0?[1-9]|[12]\\d|30))$)|(?:(?:(?:\\d{4}-0?[13-9]|1[0-2])-(?:0?[1-9]|[1-2]\\d|30))$)|(?:(?:(?:\\d{2}(?:0[48]|[13579][26]|[2468][048])|(?:(?:0[48]|[13579][26]|[2468][048])00))-0?2-29))$)$";
    private final Pattern DATE_FORMAT = Pattern.compile(DATE_PATTERN);


    @Override
    public PageResult<ErpOrder> queryPageList(OrderSearchRequest bo, PageQuery pageQuery) {
        if(org.springframework.util.StringUtils.hasText(bo.getStartTime())){
            Matcher matcher = DATE_FORMAT.matcher(bo.getStartTime());
            boolean b = matcher.find();
            if(b){
                bo.setStartTime(bo.getStartTime()+" 00:00:00");
            }
        }
        if(org.springframework.util.StringUtils.hasText(bo.getEndTime())){
            Matcher matcher = DATE_FORMAT.matcher(bo.getEndTime());
            boolean b = matcher.find();
            if(b){
                bo.setEndTime(bo.getEndTime()+" 23:59:59");
            }
        }

        LambdaQueryWrapper<ErpOrder> queryWrapper = new LambdaQueryWrapper<ErpOrder>()
                .eq(bo.getTenantId()!=null,ErpOrder::getTenantId,bo.getTenantId())
                .eq(bo.getShopId()!=null,ErpOrder::getShopId,bo.getShopId())
                .eq(bo.getOrderStatus()!=null,ErpOrder::getOrderStatus,bo.getOrderStatus())
                .eq(bo.getRefundStatus()!=null,ErpOrder::getRefundStatus,bo.getRefundStatus())
                .ge(org.springframework.util.StringUtils.hasText(bo.getStartTime()),ErpOrder::getOrderTime,bo.getStartTime())
                .le(org.springframework.util.StringUtils.hasText(bo.getEndTime()),ErpOrder::getOrderTime,bo.getEndTime())
                .eq(org.springframework.util.StringUtils.hasText(bo.getOrderNum()),ErpOrder::getOrderNum,bo.getOrderNum())
                .eq(org.springframework.util.StringUtils.hasText(bo.getReceiverName()),ErpOrder::getReceiverName,bo.getReceiverName())
                .eq(org.springframework.util.StringUtils.hasText(bo.getReceiverMobile()),ErpOrder::getReceiverMobile,bo.getReceiverMobile())
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

    @Override
    public PageResult<ErpOrder> queryWaitSelfShipmentPageList(OrderSearchRequest bo, PageQuery pageQuery) {

        LambdaQueryWrapper<ErpOrder> queryWrapper = new LambdaQueryWrapper<ErpOrder>()
                .eq(bo.getTenantId()!=null,ErpOrder::getTenantId,bo.getTenantId())
                .eq(bo.getShopId()!=null,ErpOrder::getShopId,bo.getShopId())
                .eq(ErpOrder::getOrderStatus,1)
                .eq(ErpOrder::getRefundStatus,1)
                .lt(ErpOrder::getShipType,2)//ship_type发货方式 0 自己发货1联合发货2供应商发货
                .ge(org.springframework.util.StringUtils.hasText(bo.getStartTime()),ErpOrder::getOrderTime,bo.getStartTime())
                .le(org.springframework.util.StringUtils.hasText(bo.getEndTime()),ErpOrder::getOrderTime,bo.getEndTime())
                .eq(org.springframework.util.StringUtils.hasText(bo.getOrderNum()),ErpOrder::getOrderNum,bo.getOrderNum())
                ;
        Page<ErpOrder> pages = mapper.selectPage(pageQuery.build(), queryWrapper);

        // 查询子订单
        if(pages.getRecords()!=null){
            for (var order:pages.getRecords()) {
                order.setItemList(orderItemMapper.selectList(new LambdaQueryWrapper<ErpOrderItem>()
                        .eq(ErpOrderItem::getOrderId, order.getId())
                        .eq(ErpOrderItem::getShipStatus,0)
                        .eq(ErpOrderItem::getShipType,0)
                ));
            }
        }

        return PageResult.build(pages);
    }

    @Override
    public ErpOrder queryDetailById(Long id) {
        ErpOrder order = mapper.selectById(id);
        if(order!=null){
            order.setItemList(orderItemMapper.selectList(new LambdaQueryWrapper<ErpOrderItem>().eq(ErpOrderItem::getOrderId, order.getId())));
        }
        return order;
    }

    @Transactional
    @Override
    public ResultVo<Integer> manualShipmentOrder(ErpOrderShipBo shipBo,String createBy) {
        if (StringUtils.isEmpty(shipBo.getId()) || shipBo.getId().equals("0"))
            return ResultVo.error(ResultVoEnum.ParamsError, "缺少参数：id");

        ErpOrder erpOrder = mapper.selectById(shipBo.getId());
        if (erpOrder == null) {
            return ResultVo.error("找不到订单数据");
        } else if (erpOrder.getOrderStatus().intValue() != 1 && erpOrder.getRefundStatus().intValue() != 1) {
            return ResultVo.error("订单状态不对，不允许发货");
        }
        ErpLogisticsCompany erpLogisticsCompany = erpLogisticsCompanyMapper.selectById(shipBo.getShippingCompany());
        if(erpLogisticsCompany==null) return ResultVo.error("快递公司选择错误");

        // 自己发货的list
        List<ErpOrderItem> oOrderItems = orderItemMapper.selectList(
                new LambdaQueryWrapper<ErpOrderItem>()
                .eq(ErpOrderItem::getOrderId, erpOrder.getId())
                        .eq(ErpOrderItem::getShipStatus,0)
                        .eq(ErpOrderItem::getShipType,0)
        );
        if(oOrderItems==null) return ResultVo.error("订单 item 数据错误，无法发货！");
        // 添加发货记录
        ErpShipment erpShipment = new ErpShipment();
        erpShipment.setShipper(0);//发货方 0 仓库发货 1 供应商发货】
        erpShipment.setTenantId(erpOrder.getTenantId());
        erpShipment.setShopId(erpOrder.getShopId());
        erpShipment.setShopType(erpOrder.getShopType());
        erpShipment.setOrderId(erpOrder.getId());
        erpShipment.setOrderNum(erpOrder.getOrderNum());
        erpShipment.setOrderTime(erpOrder.getOrderTime());
        erpShipment.setShipType(1);//发货类型（1订单发货2商品补发3商品换货）
        erpShipment.setShipCompany(erpLogisticsCompany.getName());
        erpShipment.setShipCompanyCode(erpLogisticsCompany.getCode());
        erpShipment.setShipCode(shipBo.getShippingNumber());
        erpShipment.setShipFee(shipBo.getShippingCost());
        erpShipment.setShipTime(new Date());
        erpShipment.setShipOperator(shipBo.getShippingMan());
        erpShipment.setShipStatus(1);//物流状态（0 待发货1已发货2已完成）

        erpShipment.setPackageHeight(shipBo.getHeight());
        erpShipment.setPackageWeight(shipBo.getWeight());
        erpShipment.setPackageLength(shipBo.getLength());
        erpShipment.setPackageWidth(shipBo.getWidth());
        erpShipment.setPacksgeOperator(shipBo.getShippingMan());
//        erpShipment.setPackages(JSONObject.toJSONString(oOrderItems));
        erpShipment.setRemark(shipBo.getRemark());
        erpShipment.setCreateBy(createBy);
        erpShipment.setCreateTime(new Date());

        shipmentMapper.insert(erpShipment);

        for(ErpOrderItem orderItem:oOrderItems){
            ErpShipmentItem erpShipmentItem = new ErpShipmentItem();
            erpShipmentItem.setShipper(erpShipment.getShipper());
            erpShipmentItem.setTenantId(erpShipment.getTenantId());
            erpShipmentItem.setShopId(erpShipment.getShopId());
            erpShipmentItem.setShopType(erpShipment.getShopType());
            erpShipmentItem.setShipmentId(erpShipment.getId());
            erpShipmentItem.setOrderId(erpShipment.getOrderId());
            erpShipmentItem.setOrderNum(erpShipment.getOrderNum());
            erpShipmentItem.setOrderTime(erpShipment.getOrderTime());
            erpShipmentItem.setOrderItemId(orderItem.getId());
            erpShipmentItem.setErpGoodsId(orderItem.getErpGoodsId());
            erpShipmentItem.setErpSkuId(orderItem.getErpSkuId());
            erpShipmentItem.setGoodsTitle(orderItem.getGoodsTitle());
            erpShipmentItem.setGoodsNum(orderItem.getGoodsNum());
            erpShipmentItem.setGoodsImg(orderItem.getGoodsImg());
            erpShipmentItem.setGoodsSpec(orderItem.getGoodsSpec());
            erpShipmentItem.setSkuNum(orderItem.getSkuNum());
            erpShipmentItem.setQuantity(orderItem.getQuantity());
            erpShipmentItem.setRemark(orderItem.getRemark());
            erpShipmentItem.setStockStatus(0);
            erpShipmentItem.setCreateBy(createBy);
            erpShipmentItem.setCreateTime(new Date());
            shipmentItemMapper.insert(erpShipmentItem);

            // 更新订单item发货状态
            ErpOrderItem orderItemUpdate = new ErpOrderItem();
            orderItemUpdate.setId( orderItem.getId());
            orderItemUpdate.setUpdateBy("手动发货");
            orderItemUpdate.setUpdateTime(new Date());
            orderItemUpdate.setShipStatus(1);//发货状态 0 待发货 1 已发货
            orderItemMapper.updateById(orderItemUpdate);
        }


        // 更新状态、发货方式
        ErpOrder update = new ErpOrder();
        update.setId(erpOrder.getId());
        update.setShipStatus(2);
        update.setOrderStatus(2);
        update.setUpdateTime(new Date());
        update.setUpdateBy("手动发货");
        mapper.updateById(update);

        return ResultVo.success();
    }

    /**
     * 分配供应商发货
     * @param shipBo
     * @param createBy
     * @return
     */
    @Override
    public ResultVo<Integer> allocateShipmentOrder(ErpOrderShipBo shipBo, String createBy) {
        if (StringUtils.isEmpty(shipBo.getId()) || shipBo.getId().equals("0"))
            return ResultVo.error(ResultVoEnum.ParamsError, "缺少参数：id");

        ErpOrder erpOrder = mapper.selectById(shipBo.getId());
        if (erpOrder == null) {
            return ResultVo.error("找不到订单数据");
        } else if (erpOrder.getOrderStatus().intValue() != 1 && erpOrder.getRefundStatus().intValue() != 1) {
            return ResultVo.error("订单状态不对，不允许发货");
        }
        List<ErpOrderItem> oOrderItems = orderItemMapper.selectList(new LambdaQueryWrapper<ErpOrderItem>().eq(ErpOrderItem::getOrderId, erpOrder.getId()));
        if(oOrderItems==null) return ResultVo.error("订单 item 数据错误，无法发货！");

        long skuIdZeroCount = oOrderItems.stream().filter(x -> x.getErpSkuId() == 0).count();
        if(skuIdZeroCount>0) return ResultVo.error("订单 item 数据中有skuId错误的数据，请补充！");

        // 按 订单明细找出同供应商 分组
        Map<Long,List<ErpOrderItem>> supplierOrderItemList = new TreeMap<>();
        Map<Long,ErpSupplier> supplierList = new TreeMap<>();
        for(ErpOrderItem orderItem:oOrderItems){
            ErpGoodsSku erpGoodsSku = erpGoodsSkuMapper.selectById(orderItem.getErpSkuId());
            if(erpGoodsSku==null) {
                return ResultVo.error("订单明细找不到商品sku信息");
            }
            ErpGoods erpGoods = erpGoodsMapper.selectById(erpGoodsSku.getGoodsId());
            if(erpGoods==null){
                return ResultVo.error("订单明细找不到商品信息");
            }
            ErpSupplier erpSupplier = erpSupplierMapper.selectById(erpGoods.getSupplierId());
            if(erpSupplier==null){
                return ResultVo.error("订单明细商品找不到供应商信息");
            }
            // 组合供应商
            boolean isExist = supplierOrderItemList.containsKey(erpSupplier.getId());
            if(isExist){
                supplierOrderItemList.get(erpSupplier.getId()).add(orderItem);
            }else{
                List<ErpOrderItem> orderItemList = new ArrayList<>();
                orderItemList.add(orderItem);
                supplierOrderItemList.put(Long.parseLong(erpSupplier.getId()),orderItemList);
            }
            supplierList.put(Long.parseLong(erpSupplier.getId()),erpSupplier);
        }

        // 开始组装分配数据
        // 遍历 Map
        for (Map.Entry<Long, List<ErpOrderItem>> entry : supplierOrderItemList.entrySet()) {
            Long supplierId = entry.getKey();  // 获取键（Long）
            List<ErpOrderItem> orderItemList = entry.getValue();  // 获取值（List<ErpOrderItem>）

            // 添加分配发货
            ErpShipment erpShipment = new ErpShipment();
            erpShipment.setShipper(1);//发货方 0 仓库发货 1 供应商发货】
            erpShipment.setSupplierId(supplierId);
            erpShipment.setSupplier(supplierList.get(supplierId)!=null?supplierList.get(supplierId).getName():"");
            erpShipment.setTenantId(erpOrder.getTenantId());
            erpShipment.setShopId(erpOrder.getShopId());
            erpShipment.setShopType(erpOrder.getShopType());
            erpShipment.setOrderId(erpOrder.getId());
            erpShipment.setOrderNum(erpOrder.getOrderNum());
            erpShipment.setOrderTime(erpOrder.getOrderTime());
            erpShipment.setShipType(1);//发货类型（1订单发货2商品补发3商品换货）
            erpShipment.setShipCompany("");
            erpShipment.setShipCompanyCode("");
            erpShipment.setShipCode("");
            erpShipment.setShipFee(BigDecimal.ZERO);
            erpShipment.setShipStatus(0);//物流状态（0 待发货1已发货2已完成）

            erpShipment.setPackageHeight(0.0);
            erpShipment.setPackageWeight(0.0);
            erpShipment.setPackageLength(0.0);
            erpShipment.setPackageWidth(0.0);
            erpShipment.setPacksgeOperator("");
//        erpShipment.setPackages(JSONObject.toJSONString(oOrderItems));
            erpShipment.setRemark("");
            erpShipment.setCreateBy(createBy);
            erpShipment.setCreateTime(new Date());

            shipmentMapper.insert(erpShipment);

            // 遍历 List<ErpOrderItem>
            for (ErpOrderItem item : orderItemList) {
                // 打印 List 中的每个 ErpOrderItem 对象
                ErpShipmentItem erpShipmentItem = new ErpShipmentItem();
                erpShipmentItem.setSupplierId(erpShipment.getSupplierId());
                erpShipmentItem.setSupplier(erpShipment.getSupplier());
                erpShipmentItem.setShipper(erpShipment.getShipper());
                erpShipmentItem.setTenantId(erpShipment.getTenantId());
                erpShipmentItem.setShopId(erpShipment.getShopId());
                erpShipmentItem.setShopType(erpShipment.getShopType());
                erpShipmentItem.setShipmentId(erpShipment.getId());
                erpShipmentItem.setOrderId(erpShipment.getOrderId());
                erpShipmentItem.setOrderNum(erpShipment.getOrderNum());
                erpShipmentItem.setOrderTime(erpShipment.getOrderTime());
                erpShipmentItem.setOrderItemId(item.getId());
                erpShipmentItem.setErpGoodsId(item.getErpGoodsId());
                erpShipmentItem.setErpSkuId(item.getErpSkuId());
                erpShipmentItem.setGoodsTitle(item.getGoodsTitle());
                erpShipmentItem.setGoodsNum(item.getGoodsNum());
                erpShipmentItem.setGoodsImg(item.getGoodsImg());
                erpShipmentItem.setGoodsSpec(item.getGoodsSpec());
                erpShipmentItem.setSkuNum(item.getSkuNum());
                erpShipmentItem.setQuantity(item.getQuantity());
                erpShipmentItem.setRemark(item.getRemark());
                erpShipmentItem.setStockStatus(0);
                erpShipmentItem.setCreateBy(createBy);
                erpShipmentItem.setCreateTime(new Date());
                shipmentItemMapper.insert(erpShipmentItem);

                // 更新订单item发货状态
                ErpOrderItem orderItemUpdate = new ErpOrderItem();
                orderItemUpdate.setId( item.getId());
                orderItemUpdate.setUpdateBy("分配供应商发货");
                orderItemUpdate.setUpdateTime(new Date());
                orderItemUpdate.setShipStatus(0);//发货状态 0 待发货 1 已发货
                orderItemUpdate.setShipType(2);//发货方式 0 自己发货 2供应商发货
                orderItemMapper.updateById(orderItemUpdate);
            }
        }

//        return ResultVo.error("还没有想好怎么实现！");

//
//        for(ErpOrderItem orderItem:oOrderItems){
//            ErpShipmentItem erpShipmentItem = new ErpShipmentItem();
//            erpShipmentItem.setShipper(erpShipment.getShipper());
//            erpShipmentItem.setTenantId(erpShipment.getTenantId());
//            erpShipmentItem.setShopId(erpShipment.getShopId());
//            erpShipmentItem.setShopType(erpShipment.getShopType());
//            erpShipmentItem.setShipmentId(erpShipment.getId());
//            erpShipmentItem.setOrderId(erpShipment.getOrderId());
//            erpShipmentItem.setOrderNum(erpShipment.getOrderNum());
//            erpShipmentItem.setOrderTime(erpShipment.getOrderTime());
//            erpShipmentItem.setOrderItemId(orderItem.getId());
//            erpShipmentItem.setErpGoodsId(orderItem.getErpGoodsId());
//            erpShipmentItem.setErpSkuId(orderItem.getErpSkuId());
//            erpShipmentItem.setGoodsTitle(orderItem.getGoodsTitle());
//            erpShipmentItem.setGoodsNum(orderItem.getGoodsNum());
//            erpShipmentItem.setGoodsImg(orderItem.getGoodsImg());
//            erpShipmentItem.setGoodsSpec(orderItem.getGoodsSpec());
//            erpShipmentItem.setSkuNum(orderItem.getSkuNum());
//            erpShipmentItem.setQuantity(orderItem.getQuantity());
//            erpShipmentItem.setRemark(orderItem.getRemark());
//            erpShipmentItem.setStockStatus(0);
//            erpShipmentItem.setCreateBy(createBy);
//            erpShipmentItem.setCreateTime(new Date());
//            shipmentItemMapper.insert(erpShipmentItem);
//        }
//
//
        // 更新状态、发货方式
        ErpOrder update = new ErpOrder();
        update.setId(erpOrder.getId());
//        update.setShipStatus(1);
        update.setShipType(2);
        update.setUpdateTime(new Date());
        update.setUpdateBy("分配供应商发货");
        mapper.updateById(update);

        return ResultVo.success();
    }

    @Override
    public List<SalesDailyVo> salesDaily(Long tenantId) {
        return mapper.salesDaily(tenantId);
    }
    @Override
    public SalesDailyVo getTodaySalesDaily(Long tenantId) {
        return mapper.getTodaySalesDaily(tenantId);
    }

    @Override
    public Integer getWaitShipOrderAllCount(Long tenantId) {
        return mapper.getWaitShipOrderAllCount(tenantId);
    }
}




