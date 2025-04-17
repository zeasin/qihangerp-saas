package cn.qihangerp.api.controller.shop;

import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.service.ErpShopPullLasttimeService;
import cn.qihangerp.api.service.ErpShopPullLogsService;
import cn.qihangerp.open.common.ApiResultVo;
import cn.qihangerp.open.wei.WeiRefundApiHelper;
import cn.qihangerp.open.wei.model.AfterSaleOrder;
import com.alibaba.fastjson2.JSONObject;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import cn.qihangerp.api.common.AjaxResult;
import cn.qihangerp.api.common.ResultVoEnum;
import cn.qihangerp.api.common.enums.EnumShopType;
import cn.qihangerp.api.common.enums.HttpStatus;
import cn.qihangerp.api.domain.*;
import cn.qihangerp.api.service.ShopRefundService;
import java.time.LocalDateTime;
import java.util.Date;

@RequestMapping("/shop/refund")
@RestController
@AllArgsConstructor
public class RefundApiController extends BaseController {
    private final ApiCommon apiCommon;
    private final ShopRefundService refundService;
    private final ErpShopPullLogsService pullLogsService;
    private final ErpShopPullLasttimeService pullLasttimeService;

    @RequestMapping(value = "/pull_list", method = RequestMethod.POST)
    public AjaxResult pullList(@RequestBody PullRequest params) throws Exception {
        if (params.getShopId() == null || params.getShopId() <= 0) {
            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，没有店铺Id");
        }

        Date currDateTime = new Date();
        long beginTime = System.currentTimeMillis();

        var checkResult = apiCommon.checkBefore(params.getShopId());
        if (checkResult.getCode() != ResultVoEnum.SUCCESS.getIndex()) {
            return AjaxResult.error(checkResult.getCode(), checkResult.getMsg(),checkResult.getData());
        }
        String accessToken = checkResult.getData().getAccessToken();
        String serverUrl = checkResult.getData().getServerUrl();
        String appKey = checkResult.getData().getAppKey();
        String appSecret = checkResult.getData().getAppSecret();

        // 获取最后更新时间
        LocalDateTime startTime = null;
        LocalDateTime  endTime = null;
        ErpShopPullLasttime lasttime = pullLasttimeService.getLasttimeByShop(getUserId(),params.getShopId(), "REFUND");
        if(lasttime == null){
            endTime = LocalDateTime.now();
            startTime = endTime.minusDays(1);
        }else{
            startTime = lasttime.getLasttime().minusHours(1);//取上次结束一个小时前
            endTime = startTime.plusDays(1);//取24小时
            if(endTime.isAfter(LocalDateTime.now())){
                endTime = LocalDateTime.now();
            }
        }

        ApiResultVo<AfterSaleOrder> apiResultVo = WeiRefundApiHelper.pullRefundList(startTime, endTime, accessToken);


        int insertSuccess = 0;//新增成功的订单
        int totalError = 0;
        int hasExistOrder = 0;//已存在的订单数

        if(apiResultVo.getCode() == 0) {
            // 拉取到了数据 拉取详情
            if(apiResultVo.getList()!=null) {
                for (var refundInfo : apiResultVo.getList()) {

                    ShopRefund refund = new ShopRefund();
//                    refund.setten
                    refund.setOrderId(refundInfo.getOrder_id());
                    refund.setAfterSaleOrderId(refundInfo.getAfter_sale_order_id());
                    refund.setShopId(params.getShopId());
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

        return AjaxResult.success();
    }
}
