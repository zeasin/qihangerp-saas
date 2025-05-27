package cn.qihangerp.api.controller.shop;

import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.service.*;
import cn.qihangerp.open.common.ApiResultVo;
import cn.qihangerp.open.pdd.PddRefundApiHelper;
import cn.qihangerp.open.pdd.model.AfterSale;
import cn.qihangerp.open.pdd.model.AfterSaleDetail;
import cn.qihangerp.open.wei.WeiRefundApiHelper;
import cn.qihangerp.open.wei.model.AfterSaleOrder;
import com.alibaba.fastjson2.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.AllArgsConstructor;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import cn.qihangerp.api.common.AjaxResult;
import cn.qihangerp.api.common.ResultVoEnum;
import cn.qihangerp.api.common.enums.EnumShopType;
import cn.qihangerp.api.common.enums.HttpStatus;
import cn.qihangerp.api.domain.*;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/shop/refund")
@RestController
@AllArgsConstructor
public class RefundApiController extends BaseController {
    private final WeiApiCommon weiApiCommon;
    private final PddApiCommon pddApiCommon;
    private final ShopRefundService refundService;
    private final ErpOrderAfterSaleService erpOrderAfterSaleService;
    private final ErpShopPullLogsService pullLogsService;
    private final ErpShopPullLasttimeService pullLasttimeService;
    private final ShopService shopService;

    /**
     * 拉取退款列表
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
        int insertSuccess = 0;//新增成功的订单
        int totalError = 0;
        int hasExistOrder = 0;//已存在的订单数
        // 定义格式化器
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        ZoneId zoneId = ZoneId.of("Asia/Shanghai");
        // 获取最后更新时间
        LocalDateTime startTime = null;
        LocalDateTime endTime = null;
        ErpShopPullLasttime lasttime = pullLasttimeService.getLasttimeByShop(getUserId(), params.getShopId(), "REFUND");


        if(shop.getType()==5) {
            var checkResult = weiApiCommon.checkBefore(params.getShopId());
            if (checkResult.getCode() != ResultVoEnum.SUCCESS.getIndex()) {
                return AjaxResult.error(checkResult.getCode(), checkResult.getMsg(), checkResult.getData());
            }
            String accessToken = checkResult.getData().getAccessToken();
//        String serverUrl = checkResult.getData().getServerUrl();
            String appKey = checkResult.getData().getAppKey();
            String appSecret = checkResult.getData().getAppSecret();
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
            ApiResultVo<AfterSaleOrder> apiResultVo = WeiRefundApiHelper.pullRefundList(startTime, endTime, accessToken);

            if (apiResultVo.getCode() == 0) {
                // 拉取到了数据 拉取详情
                if (apiResultVo.getList() != null) {
                    for (var refundInfo : apiResultVo.getList()) {

                        ShopRefund refund = new ShopRefund();
                    refund.setTenantId(shop.getTenantId());
                    refund.setShopType(shop.getType());
                    refund.setShopId(params.getShopId());
                        refund.setOrderId(refundInfo.getOrder_id());
                        refund.setAfterSaleOrderId(refundInfo.getAfter_sale_order_id());

                        refund.setStatus(refundInfo.getStatus());
                        refund.setOpenid(refundInfo.getOpenid());
                        refund.setUnionid(refundInfo.getUnionid());
                        refund.setProductId(refundInfo.getProduct_info().getString("product_id"));
                        refund.setSkuId(refundInfo.getProduct_info().getString("sku_id"));
                        refund.setCount(refundInfo.getProduct_info().getInteger("count"));
                        refund.setFastRefund(refundInfo.getProduct_info().getString("fast_refund"));
                        refund.setRefundAmount(refundInfo.getRefund_info().getInteger("amount"));
                        refund.setRefundReason(refundInfo.getRefund_info().getInteger("refund_reason"));
                        refund.setReturnWaybillId(refundInfo.getReturn_info().getString("waybill_id"));
                        refund.setReturnDeliveryName(refundInfo.getReturn_info().getString("delivery_name"));
                        refund.setReturnDeliveryId(refundInfo.getReturn_info().getString("delivery_id"));
                        refund.setMerchantUploadInfo(JSONObject.toJSONString(refundInfo.getMerchant_upload_info()));
                        refund.setCreateTime(refundInfo.getCreate_time());
                        refund.setUpdateTime(refundInfo.getUpdate_time());
                        refund.setReason(refundInfo.getReason());
                        refund.setReasonText(refundInfo.getReason_text());
                        refund.setType(refundInfo.getType());
                        refund.setComplaintId(refundInfo.getComplaint_id());
                        refund.setRefundResp(JSONObject.toJSONString(refundInfo.getRefund_resp()));
                        refund.setDetails(JSONObject.toJSONString(refundInfo.getDetails()));

                        var result = refundService.saveRefund(params.getShopId(), refund);
                        if (result.getCode() == ResultVoEnum.DataExist.getIndex()) {
                            //已经存在
//                        kafkaTemplate.send(MqType.REFUND_MQ, JSONObject.toJSONString(MqMessage.build(EnumShopType.DOU, MqType.REFUND_MESSAGE,refund.getAfterSaleOrderId())));
                            hasExistOrder++;
                        } else if (result.getCode() == ResultVoEnum.SUCCESS.getIndex()) {
//                        kafkaTemplate.send(MqType.REFUND_MQ, JSONObject.toJSONString(MqMessage.build(EnumShopType.DOU, MqType.REFUND_MESSAGE,refund.getAfterSaleOrderId())));
                            insertSuccess++;
                        } else {
                            totalError++;
                        }

                    }

                }

            }
        } else if (shop.getType()==3) {
            // 拼多多
            var checkResult = pddApiCommon.checkBefore(params.getShopId());
            if(lasttime == null){
                endTime = LocalDateTime.now();
//            startTime = endTime.minusDays(1);
                startTime = endTime.minusMinutes(30);
            }else {
                startTime = lasttime.getLasttime().minusMinutes(5);//取上次结束5分钟前
                endTime = startTime.plusMinutes(30);//结束时间取开始时间之后30分钟
                if(endTime.isAfter(LocalDateTime.now())){
                    endTime = LocalDateTime.now();
                }
            }
            String pullParams = "{startTime:"+startTime.format(formatter)+",endTime:"+endTime.format(formatter)+"}";
            Long startTimestamp = startTime.toEpochSecond(ZoneOffset.ofHours(8));
            Long endTimestamp = endTime.toEpochSecond(ZoneOffset.ofHours(8));
            if (checkResult.getCode() != ResultVoEnum.SUCCESS.getIndex()) {
                ErpShopPullLogs logs = new ErpShopPullLogs();
                logs.setTenantId(shop.getTenantId());
                logs.setShopType(shop.getType());
                logs.setShopId(Long.parseLong(shop.getId()));
                logs.setPullType("REFUND");
                logs.setPullWay("主动拉取");
                logs.setPullParams(pullParams);
                logs.setPullResult(checkResult.getMsg());
                logs.setPullTime(currDateTime);
                logs.setDuration(System.currentTimeMillis() - beginTime);
                pullLogsService.save(logs);
                return AjaxResult.error(500, checkResult.getMsg());
            }

            String accessToken = checkResult.getData().getAccessToken();
            String appKey = checkResult.getData().getAppKey();
            String appSecret = checkResult.getData().getAppSecret();
            ApiResultVo<AfterSale> upResult = PddRefundApiHelper.pullRefundList(appKey, appSecret, accessToken, startTimestamp.intValue(), endTimestamp.intValue(), 1, 10);
            if (upResult.getCode() == 10019) return AjaxResult.error(1401, upResult.getMsg());
            else if (upResult.getCode() != 0) return AjaxResult.error(upResult.getCode(), upResult.getMsg());
            if (upResult.getList() != null) {
                for (var refundInfo : upResult.getList()) {

                    ShopRefund refund = new ShopRefund();
                    refund.setTenantId(shop.getTenantId());
                    refund.setShopType(shop.getType());
                    refund.setShopId(params.getShopId());
                    refund.setOrderId(refundInfo.getOrderSn());
                    refund.setAfterSaleOrderId(refundInfo.getId().toString());
                    refund.setAfterSalesType(refundInfo.getAfterSalesType());
                    //售后类型 1：全部 2：仅退款 3：退货退款 4：换货 5：缺货补寄 6：维修
                    if(refundInfo.getAfterSalesType()==2) {
                        refund.setType("REFUND");
                    } else if (refundInfo.getAfterSalesType()==3) {
                        refund.setType("RETURN");
                    }else{
                        refund.setType(refundInfo.getAfterSalesType()+"");
                    }
                    refund.setAfterSalesStatus(refundInfo.getAfterSalesStatus());
                    //售后单当前状态，参考：
                    //USER_CANCELD	用户取消申请
                    //MERCHANT_PROCESSING	商家受理中
                    //MERCHANT_REJECT_REFUND	商家拒绝退款
                    //MERCHANT_REJECT_RETURN	商家拒绝退货退款
                    //USER_WAIT_RETURN	待买家退货
                    //RETURN_CLOSED	退货退款关闭
                    //MERCHANT_WAIT_RECEIPT	待商家收货
                    //MERCHANT_OVERDUE_REFUND	商家逾期未退款
                    //MERCHANT_REFUND_SUCCESS	退款完成
                    //MERCHANT_RETURN_SUCCESS	退货退款完成
                    //PLATFORM_REFUNDING	平台退款中
                    //PLATFORM_REFUND_FAIL	平台退款失败
                    //USER_WAIT_CONFIRM	待用户确认
                    //MERCHANT_REFUND_RETRY_FAIL	商家打款失败，客服关闭售后
                    //MERCHANT_FAIL	售后关闭
                    //USER_WAIT_CONFIRM_UPDATE	待用户处理商家协商
                    //USER_WAIT_HANDLE_MERCHANT_AFTER_SALE	待用户处理商家代发起的售后申请

                    // 售后状态
                    // 0：无售后 2：买家申请退款，待商家处理 3：退货退款，待商家处理 4：商家同意退款，退款中
                    // 5：平台同意退款，退款中 6：驳回退款，待买家处理 7：已同意退货退款,待用户发货
                    // 8：平台处理中 9：平台拒绝退款，退款关闭 10：退款成功 11：买家撤销
                    // 12：买家逾期未处理，退款失败 13：买家逾期，超过有效期 14：换货补寄待商家处理
                    // 15：换货补寄待用户处理 16：换货补寄成功 17：换货补寄失败 18：换货补寄待用户确认完成
                    // 21：待商家同意维修  22：待用户确认发货 24：维修关闭
                    // 25：维修成功 27：待用户确认收货 31：已同意拒收退款，待用户拒收 32：补寄待商家发货
                    refund.setStatus(refundInfo.getAfterSalesStatus()+"");
                    refund.setReasonText(refundInfo.getAfterSaleReason());
                    // 转换时间
                    // 将时间字符串转换为 LocalDateTime
                    LocalDateTime createTime = LocalDateTime.parse(refundInfo.getCreatedTime(), formatter);
                    // 将 LocalDateTime 转换为中国时区的 ZonedDateTime
                    Long createTimeSec = createTime.atZone(ZoneId.of("Asia/Shanghai")).toInstant().getEpochSecond();
                    LocalDateTime updateTime = LocalDateTime.parse(refundInfo.getUpdatedTime(), formatter);
                    LocalDateTime confirmTime = LocalDateTime.parse(refundInfo.getConfirmTime(), formatter);
                    Long updateTimeSec = updateTime.atZone(ZoneId.of("Asia/Shanghai")).toInstant().getEpochSecond();

                    refund.setCreateTime(createTimeSec.intValue());
                    refund.setUpdateTime(updateTimeSec.intValue());
                    refund.setConfirmTime(confirmTime);
                    refund.setDisputeRefundStatus(refundInfo.getDisputeRefundStatus());
                    refund.setGoodsImage(refundInfo.getGoodImage());
                    refund.setProductId(refundInfo.getGoodsId().toString());
                    refund.setGoodsName(refundInfo.getGoodsName());
                    refund.setCount(Integer.parseInt(refundInfo.getGoodsNumber()));
                    refund.setOrderAmount(refundInfo.getOrderAmount().doubleValue());
                    refund.setRefundAmount(refundInfo.getRefundAmount().multiply(BigDecimal.valueOf(100)).intValue());
                    refund.setSkuId(refundInfo.getSkuId());

                    refund.setReturnDeliveryName(refundInfo.getShippingName());
                    refund.setReturnWaybillId(refundInfo.getTrackingNumber());
                    refund.setUserShippingStatus(refundInfo.getUserShippingStatus());
                    refund.setCreateOn(new Date());

                    var result = refundService.saveRefund(params.getShopId(), refund);
                    if (result.getCode() == ResultVoEnum.DataExist.getIndex()) {
                        //已经存在
                        hasExistOrder++;
                    } else if (result.getCode() == ResultVoEnum.SUCCESS.getIndex()) {
                        insertSuccess++;
                    } else {
                        totalError++;
                    }

                }
            }
        }else {
            return AjaxResult.error("不支持的店铺类型！");
        }
        // 更新时间
        if(lasttime == null){
            // 新增
            ErpShopPullLasttime insertLasttime = new ErpShopPullLasttime();
            insertLasttime.setTenantId(getUserId());
            insertLasttime.setShopId(params.getShopId());
            insertLasttime.setCreateTime(new Date());
            insertLasttime.setLasttime(endTime);
            insertLasttime.setPullType("REFUND");
            pullLasttimeService.save(insertLasttime);

        }else {
            // 修改
            ErpShopPullLasttime updateLasttime = new ErpShopPullLasttime();
            updateLasttime.setId(lasttime.getId());
            updateLasttime.setUpdateTime(new Date());
            updateLasttime.setLasttime(endTime);
            pullLasttimeService.updateById(updateLasttime);
        }

        ErpShopPullLogs logs = new ErpShopPullLogs();
        logs.setShopType(EnumShopType.WEI.getIndex());
        logs.setTenantId(getUserId());
        logs.setShopId(params.getShopId());
        logs.setPullType("REFUND");
        logs.setPullWay("主动拉取");
        logs.setPullParams("{startTime:"+startTime+",endTime:"+endTime+"}");
        logs.setPullResult("{insert:"+insertSuccess+",update:"+hasExistOrder+",fail:"+totalError+"}");
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
     * 拉取退款详情
     * @param params
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pull_detail", method = RequestMethod.POST)
    public AjaxResult pullDetail(@RequestBody PullRequest params) throws Exception {
        if (params.getRefundId() == null || params.getRefundId() <= 0) {
            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，没有退款Id");
        }
        ShopRefund shopRefund = refundService.getById(params.getRefundId());
        if(shopRefund == null){
            return AjaxResult.error("没有找到退款数据");
        }
        Shop shop = shopService.getById(shopRefund.getShopId());
        if(shop==null) return AjaxResult.error("店铺不存在");

        Date currDateTime = new Date();
        long beginTime = System.currentTimeMillis();

        if(shop.getType()==5) {
            var checkResult = weiApiCommon.checkBefore(Long.parseLong(shop.getId()));
            if (checkResult.getCode() != ResultVoEnum.SUCCESS.getIndex()) {
                return AjaxResult.error(checkResult.getCode(), checkResult.getMsg(), checkResult.getData());
            }
            String accessToken = checkResult.getData().getAccessToken();
            String appKey = checkResult.getData().getAppKey();
            String appSecret = checkResult.getData().getAppSecret();

//            String pullParams = "{startTime:" + startTime.format(formatter) + ",endTime:" + endTime.format(formatter) + "}";
            ApiResultVo<AfterSaleOrder> apiResultVo = WeiRefundApiHelper.pullRefundDetail(Long.parseLong(shopRefund.getAfterSaleOrderId()), accessToken);
        }else if (shop.getType()==3) {
            // 拼多多
            var checkResult = pddApiCommon.checkBefore(Long.parseLong(shop.getId()));

            String pullParams = "{after_sales_id:" + shopRefund.getAfterSaleOrderId() + ",order_sn:" + shopRefund.getOrderId() + "}";

            if (checkResult.getCode() != ResultVoEnum.SUCCESS.getIndex()) {
                ErpShopPullLogs logs = new ErpShopPullLogs();
                logs.setTenantId(shop.getTenantId());
                logs.setShopType(shop.getType());
                logs.setShopId(Long.parseLong(shop.getId()));
                logs.setPullType("REFUND");
                logs.setPullWay("主动拉取");
                logs.setPullParams(pullParams);
                logs.setPullResult(checkResult.getMsg());
                logs.setPullTime(currDateTime);
                logs.setDuration(System.currentTimeMillis() - beginTime);
                pullLogsService.save(logs);
                return AjaxResult.error(500, checkResult.getMsg());
            }

            String accessToken = checkResult.getData().getAccessToken();
            String appKey = checkResult.getData().getAppKey();
            String appSecret = checkResult.getData().getAppSecret();
            ApiResultVo<AfterSaleDetail> upResult = PddRefundApiHelper.pullRefundDetail(appKey, appSecret, accessToken, shopRefund.getAfterSaleOrderId(), shopRefund.getOrderId());
            if (upResult.getCode() == 10019) return AjaxResult.error(1401, upResult.getMsg());
            else if (upResult.getCode() != 0) return AjaxResult.error(upResult.getCode(), upResult.getMsg());
            AfterSaleDetail data = upResult.getData();
            if (data != null) {
                ShopRefund refund = new ShopRefund();
                refund.setId(shopRefund.getId());
                refund.setAfterSalesStatus(data.getAfterSalesStatus());
                refund.setStatus(data.getAfterSalesStatus() + "");
                refund.setReasonText(data.getAfterSalesReason());
                refund.setUpdateTime(data.getUpdatedTime());
                // 将时间戳转换为 Instant
                Instant instant = Instant.ofEpochMilli(data.getConfirmTime().longValue() * 1000);
                // 转换为 LocalDateTime，指定时区
                LocalDateTime localDateTime = instant.atZone(ZoneId.systemDefault()).toLocalDateTime();
                refund.setConfirmTime(localDateTime);

                refund.setDisputeRefundStatus(data.getDisputeRefundStatus());
                refund.setCount(data.getGoodsNumber());
                refund.setRefundAmount(data.getRefundAmount());
                refund.setShippingStatus(data.getShippingStatus());

                refund.setReturnDeliveryName(data.getShippingName());
                refund.setReturnWaybillId(data.getExpressNo());
                refund.setUserShippingStatus(Integer.parseInt(data.getUserShippingStatus()));
                refund.setUpdateOn(new Date());

                var result = refundService.updateById(refund);

                // 更新售后处理单

                List<ErpOrderAfterSale> afterSaleList = erpOrderAfterSaleService.list(new LambdaQueryWrapper<ErpOrderAfterSale>().eq(ErpOrderAfterSale::getAfterSaleOrderId, shopRefund.getAfterSaleOrderId()));
                if (afterSaleList != null && afterSaleList.size() > 0) {
                    ErpOrderAfterSale afterSaleOrderUpdate = new ErpOrderAfterSale();
                    afterSaleOrderUpdate.setId(afterSaleList.get(0).getId());
                        afterSaleOrderUpdate.setReturnCompany(data.getShippingName());
                        afterSaleOrderUpdate.setReturnWaybillCode(data.getExpressNo());
                        if(StringUtils.hasText(data.getExpressNo())) {
                            afterSaleOrderUpdate.setUserShippingStatus(1);
                            afterSaleOrderUpdate.setStatus(1);//
                        }

                    afterSaleOrderUpdate.setShippingStatus(data.getShippingStatus());
                    erpOrderAfterSaleService.updateById(afterSaleOrderUpdate);

                }
            }
        }

        return AjaxResult.success();
    }
}
