package cn.qihangerp.api.controller.shop;

import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.domain.*;
import cn.qihangerp.api.service.ErpShopPullLasttimeService;
import cn.qihangerp.api.service.ErpShopPullLogsService;
import cn.qihangerp.api.service.ShopService;
import cn.qihangerp.open.common.ApiResultVo;
import cn.qihangerp.open.pdd.PddOrderApiHelper;
import cn.qihangerp.open.pdd.model.OrderListResultVo;
import cn.qihangerp.open.wei.WeiOrderApiHelper;
import cn.qihangerp.open.wei.model.Order;
import cn.qihangerp.open.wei.model.OrderDetailDeliverInfoAddress;
import com.alibaba.fastjson2.JSONObject;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import cn.qihangerp.api.common.AjaxResult;
import cn.qihangerp.api.common.ResultVoEnum;
import cn.qihangerp.api.common.enums.EnumShopType;
import cn.qihangerp.api.common.enums.HttpStatus;
import cn.qihangerp.api.service.ShopOrderService;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Slf4j
@RequestMapping("/shop/order")
@RestController
@AllArgsConstructor
public class OrderApiController extends BaseController {
    private final WeiApiCommon weiApiCommon;
    private final PddApiCommon pddApiCommon;
    private final ShopService shopService;
    private final ShopOrderService orderService;
    private final ShopOrderService weiOrderService;
    private final ErpShopPullLogsService pullLogsService;
    private final ErpShopPullLasttimeService pullLasttimeService;
    /**
     * 拉取订单
     * @param params
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pull_list", method = RequestMethod.POST)
    public AjaxResult pullList(@RequestBody PullRequest params) throws Exception {
        if (params.getShopId() == null || params.getShopId() <= 0) {
            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，没有店铺Id");
        }
        Shop shop = shopService.getById(params.getShopId());
        if(shop==null) return AjaxResult.error("店铺不存在");

        Date currDateTime = new Date();
        long beginTime = System.currentTimeMillis();

        // 定义格式化器
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        ZoneId zoneId = ZoneId.of("Asia/Shanghai");
        // 获取最后更新时间
        LocalDateTime startTime = null;
        LocalDateTime endTime = null;
        ErpShopPullLasttime lasttime = pullLasttimeService.getLasttimeByShop(getUserId(), params.getShopId(), "ORDER");
        if (lasttime == null) {
            endTime = LocalDateTime.now();
            startTime = endTime.minusDays(1);
        } else {
            startTime = lasttime.getLasttime().minusHours(1);//取上次结束一个小时前
            endTime = startTime.plusDays(1);//取24小时
            if (endTime.isAfter(LocalDateTime.now())) {
//                endTime = LocalDateTime.now();
                endTime = LocalDateTime.now(zoneId);
            }
        }
        String pullParams = "{startTime:"+startTime.format(formatter)+",endTime:"+endTime.format(formatter)+"}";

        log.info("拉取订单,开始时间：{}====结束时间：{}", startTime.format(formatter), endTime.format(formatter));
        int insertSuccess = 0;//新增成功的订单
        int totalError = 0;
        int hasExistOrder = 0;//已存在的订单数


        if(shop.getType()==5) {
            var checkResult = weiApiCommon.checkBefore(params.getShopId());
            if (checkResult.getCode() != ResultVoEnum.SUCCESS.getIndex()) {
                return AjaxResult.error(checkResult.getCode(), checkResult.getMsg(), checkResult.getData());
            }
            String accessToken = checkResult.getData().getAccessToken();
//        String serverUrl = checkResult.getData().getServerUrl();
            String appKey = checkResult.getData().getAppKey();
            String appSecret = checkResult.getData().getAppSecret();



            ApiResultVo<Order> orderApiResultVo = WeiOrderApiHelper.pullOrderList(startTime, endTime, accessToken);
            if (orderApiResultVo.getCode() != 0){
                ErpShopPullLogs logs = new ErpShopPullLogs();
                logs.setTenantId(shop.getTenantId());
                logs.setShopType(shop.getType());
                logs.setShopId(Long.parseLong(shop.getId()));
                logs.setPullType("ORDER");
                logs.setPullWay("主动拉取");
                logs.setPullParams(pullParams);
                logs.setPullResult(orderApiResultVo.getMsg());
                logs.setPullTime(currDateTime);
                logs.setDuration(System.currentTimeMillis() - beginTime);
                pullLogsService.save(logs);
            }


            if (orderApiResultVo.getCode() == 0) {
                if (orderApiResultVo.getList() != null) {
                    // 拉取到了数据 拉取详情
                    for (var orderInfo : orderApiResultVo.getList()) {

                        ShopOrder order = new ShopOrder();
                        order.setTenantId(shop.getTenantId());
                        order.setOrderId(orderInfo.getOrder_id());
                        order.setShopId(params.getShopId());
                        order.setShopType(shop.getType());
                        order.setOpenid(orderInfo.getOpenid());
                        order.setCreateTime(orderInfo.getCreate_time());
                        order.setUpdateTime(orderInfo.getUpdate_time());
                        order.setUnionid(orderInfo.getUnionid());
                        order.setStatus(orderInfo.getStatus());
                        order.setAftersaleDetail(JSONObject.toJSONString(orderInfo.getAftersale_detail()));
                        order.setPayInfo(JSONObject.toJSONString(orderInfo.getOrder_detail().getPay_info()));
                        order.setProductPrice(orderInfo.getOrder_detail().getPrice_info().getInteger("product_price"));
                        order.setOrderPrice(orderInfo.getOrder_detail().getPrice_info().getInteger("order_price"));
                        order.setFreight(orderInfo.getOrder_detail().getPrice_info().getInteger("freight"));
                        order.setDiscountedPrice(orderInfo.getOrder_detail().getPrice_info().getInteger("discounted_price"));

                        var addressInfo = orderInfo.getOrder_detail().getDelivery_info().getAddress_info();
                        order.setUserName(addressInfo.getUser_name());
                        order.setPostalCode(addressInfo.getPostal_code());
                        order.setProvinceName(addressInfo.getProvince_name());
                        order.setCityName(addressInfo.getCity_name());
                        order.setCountyName(addressInfo.getCounty_name());
                        order.setDetailInfo(addressInfo.getDetail_info());
                        order.setTelNumber(addressInfo.getTel_number());
                        order.setHouseNumber(addressInfo.getHouse_number());
                        order.setVirtualOrderTelNumber(addressInfo.getVirtual_order_tel_number());
                        order.setTelNumberExtInfo(JSONObject.toJSONString(addressInfo.getTel_number_ext_info()));
                        order.setUseTelNumber(addressInfo.getUse_tel_number());
                        order.setHashCode(addressInfo.getHash_code());

                        order.setDeliveryProductInfo(JSONObject.toJSONString(orderInfo.getOrder_detail().getDelivery_info().getDelivery_product_info()));

                        order.setShipDoneTime(orderInfo.getOrder_detail().getDelivery_info().getShip_done_time());
                        order.setEwaybillOrderCode(orderInfo.getOrder_detail().getDelivery_info().getEwaybill_order_code());

                        order.setSettleInfo(JSONObject.toJSONString(orderInfo.getOrder_detail().getSettle_info()));

                        List<ShopOrderItem> itemList = new ArrayList<>();
                        for (var item : orderInfo.getOrder_detail().getProduct_infos()) {
                            ShopOrderItem oi = new ShopOrderItem();
                            oi.setTenantId(order.getTenantId());
                            oi.setShopOrderId(order.getOrderId());
                            oi.setShopId(Long.parseLong(shop.getId()));
                            oi.setShopType(shop.getType());
                            oi.setProductId(item.getProduct_id());
                            oi.setSkuId(item.getSku_id());
                            oi.setThumbImg(item.getThumb_img());
                            oi.setSkuCnt(item.getSku_cnt());
                            oi.setSalePrice(item.getSale_price());
                            oi.setTitle(item.getTitle());
                            oi.setOnAftersaleSkuCnt(item.getOn_aftersale_sku_cnt());
                            oi.setFinishAftersaleSkuCnt(item.getFinish_aftersale_sku_cnt());
                            oi.setSkuCode(item.getSku_code());
                            oi.setMarketPrice(item.getMarket_price());
                            oi.setRealPrice(item.getReal_price());
                            oi.setOutProductId(item.getOut_product_id());
                            oi.setOutSkuId(item.getOut_sku_id());
                            oi.setIsDiscounted(item.getIs_discounted() + "");
                            oi.setEstimatePrice(item.getEstimate_price());
                            oi.setIsChangePrice(item.getIs_change_price() + "");
                            oi.setChangePrice(item.getChange_price());
                            oi.setOutWarehouseId(item.getOut_warehouse_id());
                            oi.setUseDeduction(item.getUse_deduction() + "");

                            oi.setSkuAttrs(JSONObject.toJSONString(item.getSku_attrs()));
                            oi.setSkuDeliverInfo(JSONObject.toJSONString(item.getSku_deliver_info()));
                            oi.setExtraService(JSONObject.toJSONString(item.getExtra_service()));
                            oi.setOrderProductCouponInfoList(JSONObject.toJSONString(item.getOrder_product_coupon_info_list()));
                            itemList.add(oi);
                        }
                        order.setItems(itemList);
                        var result = weiOrderService.saveOrder(params.getShopId(), order);
                        if (result.getCode() == ResultVoEnum.DataExist.getIndex()) {
                            //已经存在
                            hasExistOrder++;
                            String[] ids = new String[]{result.getData().toString()};
                            ResultVo<Integer> resultVo = orderService.orderConfirm(ids);
                            log.info("======店铺订单同步更新OMS订单库====={}", JSONObject.toJSONString(resultVo));
                        } else if (result.getCode() == ResultVoEnum.SUCCESS.getIndex()) {
                            insertSuccess++;
                            String[] ids = new String[]{result.getData().toString()};
                            ResultVo<Integer> resultVo = orderService.orderConfirm(ids);
                            log.info("======店铺订单新增到OMS订单库====={}", JSONObject.toJSONString(resultVo));
                        } else {
                            totalError++;
                        }
                    }
                }
            }
        } else if (shop.getType()==3) {
            // 拼多多
            var checkResult = pddApiCommon.checkBefore(params.getShopId());
            if (checkResult.getCode() != ResultVoEnum.SUCCESS.getIndex()) {
//            return AjaxResult.error(checkResult.getCode(), checkResult.getMsg(), checkResult.getData());
                ErpShopPullLogs logs = new ErpShopPullLogs();
                logs.setTenantId(shop.getTenantId());
                logs.setShopType(shop.getType());
                logs.setShopId(Long.parseLong(shop.getId()));
                logs.setPullType("ORDER");
                logs.setPullWay("主动拉取");
                logs.setPullParams(pullParams);
                logs.setPullResult(checkResult.getMsg());
                logs.setPullTime(currDateTime);
                logs.setDuration(System.currentTimeMillis() - beginTime);
                pullLogsService.save(logs);
                return AjaxResult.error(500, checkResult.getMsg());
            }
            String accessToken = checkResult.getData().getAccessToken();
//        String serverUrl = checkResult.getData().getServerUrl();
            String appKey = checkResult.getData().getAppKey();
            String appSecret = checkResult.getData().getAppSecret();
            Long startTimestamp = startTime.toEpochSecond(ZoneOffset.ofHours(8));
            Long endTimestamp = endTime.toEpochSecond(ZoneOffset.ofHours(8));

            ApiResultVo<OrderListResultVo> upResult = PddOrderApiHelper.pullOrderList(appKey, appSecret, accessToken, startTimestamp.intValue(), endTimestamp.intValue(), 1, 20);
            if (upResult.getCode() == 10019) return AjaxResult.error(1401, upResult.getMsg());
            else if (upResult.getCode() != 0) return AjaxResult.error(upResult.getCode(), upResult.getMsg());
            if (upResult.getCode() != 0){
                ErpShopPullLogs logs = new ErpShopPullLogs();
                logs.setTenantId(shop.getTenantId());
                logs.setShopType(shop.getType());
                logs.setShopId(Long.parseLong(shop.getId()));
                logs.setPullType("ORDER");
                logs.setPullWay("主动拉取");
                logs.setPullParams(pullParams);
                logs.setPullResult(upResult.getMsg());
                logs.setPullTime(currDateTime);
                logs.setDuration(System.currentTimeMillis() - beginTime);
                pullLogsService.save(logs);
            }else {
                // 拉取成功
                //循环插入订单数据到数据库
                for (var trade : upResult.getData().getOrderList()) {
                    ShopOrder order = new ShopOrder();
                    order.setTenantId(shop.getTenantId());
                    order.setShopId(params.getShopId());
                    order.setShopType(shop.getType());
//                    order.setOrderId(orderInfo.getOrder_id());
//                    PddOrder pddOrder = new PddOrder();
//                    BeanUtils.copyProperties(trade,pddOrder);
//                    List<PddOrderItem> items = new ArrayList<>();
//                    for (var it:trade.getItemList()) {
//                        PddOrderItem item = new PddOrderItem();
//                        BeanUtils.copyProperties(it,item);
//                        items.add(item);
//                    }
//                    pddOrder.setItems(items);
//                    //插入订单数据
//                    var result = orderService.saveOrder(req.getShopId(), pddOrder);
//                    if (result.getCode() == ResultVoEnum.DataExist.getIndex()) {
//                        //已经存在
//                        log.info("/**************主动更新pdd订单：开始更新数据库：" + pddOrder.getOrderSn() + "存在、更新************开始通知****/");
//                        mqUtils.sendApiMessage(MqMessage.build(EnumShopType.PDD, MqType.ORDER_MESSAGE,pddOrder.getOrderSn()));
//                        hasExistOrder++;
//                    } else if (result.getCode() == ResultVoEnum.SUCCESS.getIndex()) {
//                        log.info("/**************主动更新pdd订单：开始更新数据库：" + pddOrder.getOrderSn() + "不存在、新增************开始通知****/");
//                        mqUtils.sendApiMessage(MqMessage.build(EnumShopType.PDD,MqType.ORDER_MESSAGE,pddOrder.getOrderSn()));
//                        insertSuccess++;
//                    } else {
//                        log.info("/**************主动更新pdd订单：开始更新数据库：" + pddOrder.getOrderSn() + "报错****************/");
//                        totalError++;
//                    }
                }
            }


        }else {
            return AjaxResult.error("不支持的店铺类型！");
        }

        // 更新时间
        if (lasttime == null) {
            // 新增
            ErpShopPullLasttime insertLasttime = new ErpShopPullLasttime();
            insertLasttime.setTenantId(shop.getTenantId());
            insertLasttime.setShopId(Long.parseLong(shop.getId()));
            insertLasttime.setCreateTime(new Date());
            insertLasttime.setLasttime(endTime);
            insertLasttime.setPullType("ORDER");
            pullLasttimeService.save(insertLasttime);

        } else {
            // 修改
            ErpShopPullLasttime updateLasttime = new ErpShopPullLasttime();
            updateLasttime.setId(lasttime.getId());
            updateLasttime.setUpdateTime(new Date());
            updateLasttime.setLasttime(endTime);
            pullLasttimeService.updateById(updateLasttime);
        }

        ErpShopPullLogs logs = new ErpShopPullLogs();
        logs.setTenantId(shop.getTenantId());
        logs.setShopType(shop.getType());
        logs.setShopId(Long.parseLong(shop.getId()));
        logs.setPullType("ORDER");
        logs.setPullWay("主动拉取");
        logs.setPullParams("{startTime:" + startTime + ",endTime:" + endTime + "}");
        logs.setPullResult("{insert:" + insertSuccess + ",update:" + hasExistOrder + ",fail:" + totalError + "}");
        logs.setPullTime(currDateTime);
        logs.setDuration(System.currentTimeMillis() - beginTime);
        pullLogsService.save(logs);


        Map<String, Object> data = new HashMap<>();
        data.put("startTime", startTime.format(formatter));
        data.put("endTime", endTime.format(formatter));
        data.put("insert", insertSuccess);
        data.put("update", hasExistOrder);
        data.put("fail", totalError);
        data.put("total", insertSuccess + hasExistOrder+totalError);
        return AjaxResult.success(data);
    }

    /**
     * 拉取订单详情
     * @param params
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pull_detail", method = RequestMethod.POST)
    public AjaxResult pullDetail(@RequestBody PullRequest params) throws Exception {
        if (params.getShopId() == null || params.getShopId() <= 0) {
            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，没有店铺Id");
        }
        if (params.getOrderId()==null || params.getOrderId() <= 0) {
            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，没有订单编号");
        }
        Shop shop = shopService.getById(params.getShopId());
        if(shop==null) return AjaxResult.error("店铺不存在");

        Date currDateTime = new Date();
        long beginTime = System.currentTimeMillis();

        var checkResult = weiApiCommon.checkBefore(params.getShopId());
        if (checkResult.getCode() != ResultVoEnum.SUCCESS.getIndex()) {
            return AjaxResult.error(checkResult.getCode(), checkResult.getMsg(), checkResult.getData());
        }
        String accessToken = checkResult.getData().getAccessToken();
//        String serverUrl = checkResult.getData().getServerUrl();
        String appKey = checkResult.getData().getAppKey();
        String appSecret = checkResult.getData().getAppSecret();

        ApiResultVo<Order> apiResultVo = WeiOrderApiHelper.pullOrderDetail(params.getOrderId(), accessToken);
        if(apiResultVo.getCode() == 0) {
            if (apiResultVo.getData() != null) {

                ShopOrder order = new ShopOrder();
                order.setOrderId(apiResultVo.getData().getOrder_id());
//                order.setShopId(params.getShopId());
                order.setOpenid(apiResultVo.getData().getOpenid());
                order.setCreateTime(apiResultVo.getData().getCreate_time());
                order.setUpdateTime(apiResultVo.getData().getUpdate_time());
                order.setUnionid(apiResultVo.getData().getUnionid());
                order.setStatus(apiResultVo.getData().getStatus());
                order.setAftersaleDetail(JSONObject.toJSONString(apiResultVo.getData().getAftersale_detail()));
                order.setPayInfo(JSONObject.toJSONString(apiResultVo.getData().getOrder_detail().getPay_info()));
                order.setProductPrice(apiResultVo.getData().getOrder_detail().getPrice_info().getInteger("product_price"));
                order.setOrderPrice(apiResultVo.getData().getOrder_detail().getPrice_info().getInteger("order_price"));
                order.setFreight(apiResultVo.getData().getOrder_detail().getPrice_info().getInteger("freight"));
                order.setDiscountedPrice(apiResultVo.getData().getOrder_detail().getPrice_info().getInteger("discounted_price"));

                OrderDetailDeliverInfoAddress addressInfo = apiResultVo.getData().getOrder_detail().getDelivery_info().getAddress_info();
                order.setUserName(addressInfo.getUser_name());
                order.setPostalCode(addressInfo.getPostal_code());
                order.setProvinceName(addressInfo.getProvince_name());
                order.setCityName(addressInfo.getCity_name());
                order.setCountyName(addressInfo.getCounty_name());
                order.setDetailInfo(addressInfo.getDetail_info());
                order.setTelNumber(addressInfo.getTel_number());
                order.setHouseNumber(addressInfo.getHouse_number());
                order.setVirtualOrderTelNumber(addressInfo.getVirtual_order_tel_number());
                order.setTelNumberExtInfo(JSONObject.toJSONString(addressInfo.getTel_number_ext_info()));
                order.setUseTelNumber(addressInfo.getUse_tel_number());
                order.setHashCode(addressInfo.getHash_code());

                order.setDeliveryProductInfo(JSONObject.toJSONString(apiResultVo.getData().getOrder_detail().getDelivery_info().getDelivery_product_info()));

                order.setShipDoneTime(apiResultVo.getData().getOrder_detail().getDelivery_info().getShip_done_time());
                order.setEwaybillOrderCode(apiResultVo.getData().getOrder_detail().getDelivery_info().getEwaybill_order_code());

                order.setSettleInfo(JSONObject.toJSONString(apiResultVo.getData().getOrder_detail().getSettle_info()));

                List<ShopOrderItem> itemList = new ArrayList<>();
                for (var item : apiResultVo.getData().getOrder_detail().getProduct_infos()) {
                    ShopOrderItem oi = new ShopOrderItem();
                    oi.setShopOrderId(order.getOrderId());
                    oi.setShopId(params.getShopId());
                    oi.setProductId(item.getProduct_id());
                    oi.setSkuId(item.getSku_id());
                    oi.setThumbImg(item.getThumb_img());
                    oi.setSkuCnt(item.getSku_cnt());
                    oi.setSalePrice(item.getSale_price());
                    oi.setTitle(item.getTitle());
                    oi.setOnAftersaleSkuCnt(item.getOn_aftersale_sku_cnt());
                    oi.setFinishAftersaleSkuCnt(item.getFinish_aftersale_sku_cnt());
                    oi.setSkuCode(item.getSku_code());
                    oi.setMarketPrice(item.getMarket_price());
                    oi.setRealPrice(item.getReal_price());
                    oi.setOutProductId(item.getOut_product_id());
                    oi.setOutSkuId(item.getOut_sku_id());
                    oi.setIsDiscounted(item.getIs_discounted() + "");
                    oi.setEstimatePrice(item.getEstimate_price());
                    oi.setIsChangePrice(item.getIs_change_price() + "");
                    oi.setChangePrice(item.getChange_price());
                    oi.setOutWarehouseId(item.getOut_warehouse_id());
                    oi.setUseDeduction(item.getUse_deduction() + "");

                    oi.setSkuAttrs(JSONObject.toJSONString(item.getSku_attrs()));
                    oi.setSkuDeliverInfo(JSONObject.toJSONString(item.getSku_deliver_info()));
                    oi.setExtraService(JSONObject.toJSONString(item.getExtra_service()));
                    oi.setOrderProductCouponInfoList(JSONObject.toJSONString(item.getOrder_product_coupon_info_list()));
                    itemList.add(oi);
                }
                order.setItems(itemList);
                ResultVo<Long> result = weiOrderService.saveOrder(params.getShopId(), order);
                String[] ids = new String[] {result.getData().toString()};
                ResultVo<Integer> resultVo = orderService.orderConfirm(ids);
                log.info("======店铺订单同步更新OMS订单库====={}",JSONObject.toJSONString(resultVo));
            }
        }

        return AjaxResult.success();
    }
}


