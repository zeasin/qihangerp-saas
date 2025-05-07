package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.*;
import cn.qihangerp.api.common.utils.DateUtils;
import cn.qihangerp.api.domain.*;
import cn.qihangerp.api.mapper.*;
import cn.qihangerp.api.request.ShopOrderCreateBo;
import cn.qihangerp.api.request.ShopOrderSearchRequest;
import cn.qihangerp.api.service.ShopService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.StringUtils;
import cn.qihangerp.api.common.enums.EnumShopType;
import cn.qihangerp.api.service.ShopOrderService;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
* @author qilip
* @description 针对表【wei_order】的数据库操作Service实现
* @createDate 2024-04-03 21:36:32
*/
@AllArgsConstructor
@Service
public class ShopOrderServiceImpl extends ServiceImpl<ShopOrderMapper, ShopOrder>
    implements ShopOrderService {
    private final ShopOrderMapper mapper;
    private final ShopOrderItemMapper itemMapper;
    private final ErpOrderMapper erpOrderMapper;
    private final ErpOrderItemMapper erpOrderItemMapper;
    private final ShopGoodsSkuMapper goodsSkuMapper;
    private final ShopService shopService;

    private final String DATE_PATTERN =
            "^(?:(?:(?:\\d{4}-(?:0?[1-9]|1[0-2])-(?:0?[1-9]|1\\d|2[0-8]))|(?:(?:(?:\\d{2}(?:0[48]|[2468][048]|[13579][26])|(?:(?:0[48]|[2468][048]|[13579][26])00))-0?2-29))$)|(?:(?:(?:\\d{4}-(?:0?[13578]|1[02]))-(?:0?[1-9]|[12]\\d|30))$)|(?:(?:(?:\\d{4}-0?[13-9]|1[0-2])-(?:0?[1-9]|[1-2]\\d|30))$)|(?:(?:(?:\\d{2}(?:0[48]|[13579][26]|[2468][048])|(?:(?:0[48]|[13579][26]|[2468][048])00))-0?2-29))$)$";
    private final Pattern DATE_FORMAT = Pattern.compile(DATE_PATTERN);
    @Override
    public PageResult<ShopOrder> queryPageList(ShopOrderSearchRequest bo, PageQuery pageQuery) {
        Long startTime = null;
        Long endTime = null;

        if(org.springframework.util.StringUtils.hasText(bo.getStartTime())){
            Matcher matcher = DATE_FORMAT.matcher(bo.getStartTime());
            boolean b = matcher.find();
            if(b){
//                bo.setStartTime(bo.getStartTime()+" 00:00:00");
               startTime = DateUtils.parseDate(bo.getStartTime()+" 00:00:00").getTime() /1000;
            }
        }
        if(org.springframework.util.StringUtils.hasText(bo.getEndTime())){
            Matcher matcher = DATE_FORMAT.matcher(bo.getEndTime());
            boolean b = matcher.find();
            if(b){
//                bo.setEndTime(bo.getEndTime()+" 23:59:59");
                endTime = DateUtils.parseDate(bo.getEndTime()+" 23:59:59").getTime() /1000;
            }
        }
        pageQuery.setOrderByColumn("create_time");
        pageQuery.setIsAsc("desc");


        LambdaQueryWrapper<ShopOrder> queryWrapper = new LambdaQueryWrapper<ShopOrder>()
                .eq(bo.getStatus()!=null, ShopOrder::getStatus,bo.getStatus())
                .eq(bo.getShopId()!=null, ShopOrder::getShopId,bo.getShopId())
                .eq(bo.getTenantId()!=null, ShopOrder::getTenantId,bo.getTenantId())
                .ge(startTime!=null, ShopOrder::getCreateTime,startTime)
                .le(endTime!=null, ShopOrder::getCreateTime,endTime)
                .eq(StringUtils.hasText(bo.getOrderId()), ShopOrder::getOrderId,bo.getOrderId())
                ;

        Page<ShopOrder> taoGoodsPage = mapper.selectPage(pageQuery.build(), queryWrapper);
        if(taoGoodsPage.getRecords()!=null){
            for (var order:taoGoodsPage.getRecords()) {
                order.setItems(itemMapper.selectList(new LambdaQueryWrapper<ShopOrderItem>().eq(ShopOrderItem::getShopOrderId,order.getId())));
            }
        }
        return PageResult.build(taoGoodsPage);
    }

    @Transactional
    @Override
    public ResultVo<Long> saveOrder(Long shopId, ShopOrder order) {
        Shop shop = shopService.getById(shopId);
        if(shop==null) return ResultVo.error("店铺不存在");
        try {
            List<ShopOrder> orders = mapper.selectList(new LambdaQueryWrapper<ShopOrder>().eq(ShopOrder::getOrderId, order.getOrderId()));
            if (orders != null && orders.size() > 0) {
                // 存在，修改
                ShopOrder update = new ShopOrder();
                update.setShopId(shopId);
                update.setTenantId(shop.getTenantId());
                update.setId(orders.get(0).getId());
                update.setStatus(order.getStatus());
                update.setUpdateTime(order.getUpdateTime());
                update.setPayInfo(order.getPayInfo());
                update.setAftersaleDetail(order.getAftersaleDetail());
                update.setDeliveryProductInfo(order.getDeliveryProductInfo());

                mapper.updateById(update);
                // 更新item
                for (var item : order.getItems()) {
                    List<ShopOrderItem> taoOrderItems = itemMapper.selectList(new LambdaQueryWrapper<ShopOrderItem>().eq(ShopOrderItem::getSkuId, item.getSkuId()));
                    if (taoOrderItems != null && taoOrderItems.size() > 0) {
                        // 不处理
                        item.setId(taoOrderItems.get(0).getId());
                        item.setShopId(shopId);
                        item.setTenantId(shop.getTenantId());
                        itemMapper.updateById(item);
                    } else {
                        // 新增
                        item.setShopId(shopId);
                        item.setTenantId(shop.getTenantId());
                        item.setShopOrderId(update.getId());
                        itemMapper.insert(item);
                    }
                }
                return ResultVo.error(ResultVoEnum.DataExist.getIndex(), "订单已经存在，更新成功",Long.parseLong(update.getId()));
            } else {
                // 不存在，新增
                order.setShopId(shopId);
                order.setTenantId(shop.getTenantId());
                mapper.insert(order);
                // 添加item
                for (var item : order.getItems()) {
                    item.setShopId(shopId);
                    item.setTenantId(shop.getTenantId());
                    item.setShopOrderId(order.getId());
                    itemMapper.insert(item);
                }
                return ResultVo.success(Long.parseLong(order.getId()));
            }
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultVo.error(ResultVoEnum.SystemException, "系统异常：" + e.getMessage());
        }
    }

    @Transactional
    @Override
    public ResultVo<Integer> orderConfirm(String[] ids) {
        if(ids!=null && ids.length >0) {
            Integer success =0;
            for(var id : ids){
                if(StringUtils.hasText(id)) {
                    // 查询订单
                    ShopOrder weiOrder = mapper.selectById(id);
                    if(weiOrder!=null){
                        // 查询是否确认过
//                        if(weiOrder.getConfirmStatus() == null || weiOrder.getConfirmStatus() == 0){
                            // 确认状态是null或者0
                            List<ErpOrder> erpOrders = erpOrderMapper.selectList(new LambdaQueryWrapper<ErpOrder>()
                                    .eq(ErpOrder::getOrderNum, weiOrder.getOrderId())
                                    .eq(ErpOrder::getShopId, weiOrder.getShopId()));
                            //订单状态转换
                        // 状态 订单状态0：新订单，1：待发货，2：已发货，3：已完成，11已取消；12退款中；21待付款；22锁定，29删除，101部分发货
                        Integer orderStatus = null;
                        Integer refundStatus = null;
                        Integer originOrderStatus = weiOrder.getStatus();
                        //状态 10	待付款；20	待发货；21	部分发货；30	待收货；100	完成；200	全部商品售后之后，订单取消；250	未付款用户主动取消或超时未付款订单自动取消；
                        if(originOrderStatus == 10||originOrderStatus == 12){
                            orderStatus = 21;
                            refundStatus = 1;
                        } else if (originOrderStatus == 20 || originOrderStatus == 21) {
                            orderStatus = 1;
                            refundStatus = 1;
                        } else if (originOrderStatus == 30) {
                            orderStatus = 2;
                            refundStatus = 1;
                        } else if (originOrderStatus == 100) {
                            orderStatus = 3;
                            refundStatus = 1;
                        }else if (originOrderStatus == 200) {
                            orderStatus = 11;
                            refundStatus = 4;
                        }else if ( originOrderStatus == 250) {
                            orderStatus = 11;
                            refundStatus = 11;
                        }
                            if(erpOrders==null||erpOrders.size()==0){
                                // 没有数据，开始插入订单数据
                                ErpOrder insert = new ErpOrder();
                                insert.setTenantId(weiOrder.getTenantId());
                                insert.setOrderNum(weiOrder.getOrderId());
                                insert.setShopType(EnumShopType.WEI.getIndex());
                                insert.setShopId(weiOrder.getShopId());
                                insert.setRefundStatus(refundStatus);
                                insert.setOrderStatus(orderStatus);

                                insert.setGoodsAmount(weiOrder.getProductPrice().doubleValue()/100);
                                insert.setAmount(weiOrder.getOrderPrice().doubleValue()/100);
                                insert.setReceiverName(weiOrder.getUserName());
                                insert.setReceiverMobile(weiOrder.getTelNumber());
                                insert.setProvince(weiOrder.getProvinceName());
                                insert.setCity(weiOrder.getCityName());
                                insert.setTown(weiOrder.getCountyName());
                                insert.setAddress(weiOrder.getDetailInfo());
                                insert.setShipType(-1);
                                Long orderTime =weiOrder.getCreateTime().longValue();
                                insert.setOrderTime(new Date(orderTime*1000));

                                insert.setCreateTime(new Date());
                                insert.setCreateBy("手动确认");
                                erpOrderMapper.insert(insert);

                                // 插入order_item
                                List<ShopOrderItem> weiOrderItems = itemMapper.selectList(new LambdaQueryWrapper<ShopOrderItem>().eq(ShopOrderItem::getShopOrderId, weiOrder.getId()));
                                for(var item :weiOrderItems) {
                                    ErpOrderItem itemInsert = new ErpOrderItem();
                                    itemInsert.setTenantId(weiOrder.getTenantId());
                                    itemInsert.setShopId(weiOrder.getShopId());
                                    itemInsert.setOrderId(insert.getId());
                                    itemInsert.setOrderNum(weiOrder.getOrderId());
                                    itemInsert.setSubOrderNum(item.getId()+"");
                                    itemInsert.setSkuId(item.getSkuId());
                                    // TODO:skuId需要查询erp系统的
                                    itemInsert.setErpGoodsId(item.getErpGoodsId());
                                    itemInsert.setErpSkuId(item.getErpSkuId());
                                    itemInsert.setGoodsTitle(item.getTitle());
                                    itemInsert.setGoodsImg(item.getThumbImg());
                                    itemInsert.setGoodsNum(item.getOutProductId());
                                    itemInsert.setSkuNum(item.getSkuCode());
                                    itemInsert.setGoodsSpec(item.getSkuAttrs());
                                    if(item.getMarketPrice()!=null) {
                                        itemInsert.setGoodsPrice(item.getMarketPrice().doubleValue() / 100);
                                    }
                                    if(item.getRealPrice()!=null){
                                        itemInsert.setItemAmount(item.getRealPrice().doubleValue()/100);
                                    }
                                    itemInsert.setQuantity(item.getSkuCnt());
                                    itemInsert.setRefundCount(0);
                                    itemInsert.setRefundStatus(1);
                                    erpOrderItemMapper.insert(itemInsert);
                                }
                                // 更新wei_order确认状态
                                ShopOrder update = new ShopOrder();
                                update.setId(weiOrder.getId());
                                update.setConfirmStatus(1);
                                update.setConfirmTime(new Date());
                                mapper.updateById(update);
                                success++;
                            }else{
                                // 更新订单状态
                                ErpOrder update = new ErpOrder();
                                update.setShopId(weiOrder.getShopId());
                                update.setTenantId(weiOrder.getTenantId());
                                update.setId(erpOrders.get(0).getId());
                                update.setRefundStatus(refundStatus);
                                update.setOrderStatus(orderStatus);
                                update.setUpdateTime(new Date());
                                Long orderTime =weiOrder.getCreateTime().longValue();
                                update.setOrderTime(new Date(orderTime*1000));
                                erpOrderMapper.updateById(update);
                            }
//                        }
                    }
                }
            }
            return ResultVo.success(success);
        }else {
            return ResultVo.error(ResultVoEnum.ParamsError, "没有订单ID：");
        }
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public ResultVo insertOrder(ShopOrderCreateBo bo, String createBy) {
        if(!StringUtils.hasText(bo.getOrderId())) return ResultVo.error("请输入订单号");
        if(bo.getShopId()==null) return ResultVo.error("请选择店铺");
        if(!StringUtils.hasText(bo.getOrderTime())) return ResultVo.error("请选择下单时间");
        if(bo.getStatus()==null) return ResultVo.error("请选择订单状态");
        if(bo.getItemList()==null || bo.getItemList().isEmpty()) return ResultVo.error("请添加商品");

        Matcher matcher = DATE_FORMAT.matcher(bo.getOrderTime());
        if(matcher.find()) return ResultVo.error("下单时间格式不正确");


        List<ShopOrder> shopOrders = mapper.selectList(new LambdaQueryWrapper<ShopOrder>()
                .eq(ShopOrder::getShopId, bo.getShopId())
                .eq(ShopOrder::getOrderId, bo.getOrderId()));
        if(shopOrders!=null && shopOrders.size()>0) return ResultVo.error("订单已存在");

        ShopOrder shopOrder = new ShopOrder();
        shopOrder.setShopId(bo.getShopId());
        shopOrder.setOrderId(bo.getOrderId());
        shopOrder.setTenantId(bo.getTenantId());
        shopOrder.setCreateTime(Integer.parseInt(DateUtils.parseDate(bo.getOrderTime()).getTime()/1000+""));
        shopOrder.setUpdateTime(0);
        shopOrder.setStatus(bo.getStatus());
        shopOrder.setProductPrice(BigDecimal.valueOf(bo.getGoodsAmount()*100).intValue());
        shopOrder.setOrderPrice(BigDecimal.valueOf(bo.getOrderAmount()*100).intValue());
        shopOrder.setFreight(0);
        shopOrder.setDiscountedPrice(0);
        shopOrder.setUserName(bo.getReceiverName());
        shopOrder.setProvinceName(bo.getProvince());
        shopOrder.setCityName(bo.getCity());
        shopOrder.setCountyName(bo.getCounty());
        shopOrder.setDetailInfo("");
        shopOrder.setTelNumber(bo.getReceiverPhone());
        shopOrder.setUseTelNumber(0);
        shopOrder.setShipDoneTime(0);
        shopOrder.setConfirmStatus(0);
        shopOrder.setErpSendStatus(0);
        mapper.insert(shopOrder);

        //添加item
        for(var item : bo.getItemList()){
            ShopOrderItem shopOrderItem = new ShopOrderItem();
            shopOrderItem.setShopOrderId(shopOrder.getId());
            shopOrderItem.setTenantId(shopOrder.getTenantId());
            shopOrderItem.setShopId(shopOrder.getShopId());
            //查询店铺商品
            List<ShopGoodsSku> shopGoodsSkus = goodsSkuMapper.selectList(new LambdaQueryWrapper<ShopGoodsSku>().eq(ShopGoodsSku::getErpGoodsSkuId, item.getSkuId()));
            if(shopGoodsSkus!=null && shopGoodsSkus.size()>0) {
                shopOrderItem.setProductId(shopGoodsSkus.get(0).getProductId());
                shopOrderItem.setSkuId(shopGoodsSkus.get(0).getSkuId());
            }
            shopOrderItem.setThumbImg(item.getGoodsImg());
            shopOrderItem.setSkuCnt(item.getQuantity());
            shopOrderItem.setSalePrice(item.getGoodsPrice().multiply(BigDecimal.valueOf(100)).intValue());
            shopOrderItem.setTitle(item.getGoodsName());
            shopOrderItem.setOnAftersaleSkuCnt(0);
            shopOrderItem.setFinishAftersaleSkuCnt(0);
            shopOrderItem.setSkuCode(item.getSkuCode());
            shopOrderItem.setMarketPrice(item.getGoodsPrice().multiply(BigDecimal.valueOf(100)).intValue());
            shopOrderItem.setRealPrice(item.getGoodsPrice().multiply(BigDecimal.valueOf(100)).intValue());
            shopOrderItem.setSkuAttrs(item.getSkuName());
            shopOrderItem.setErpGoodsId(Long.parseLong(item.getGoodsId()));
            shopOrderItem.setErpSkuId(Long.parseLong(item.getSkuId()));
            itemMapper.insert(shopOrderItem);
        }
        String[] ids = new String[]{shopOrder.getId()};
        orderConfirm(ids);
        return ResultVo.success();
    }
}




