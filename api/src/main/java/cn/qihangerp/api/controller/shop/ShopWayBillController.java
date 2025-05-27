package cn.qihangerp.api.controller.shop;

import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.Shop;
import cn.qihangerp.api.domain.ShopRefund;
import cn.qihangerp.api.domain.ShopWaybillAccount;
import cn.qihangerp.api.service.ShopService;
import cn.qihangerp.api.service.ShopWaybillAccountService;
import cn.qihangerp.open.common.ApiResultVo;
import cn.qihangerp.open.wei.WeiLogisticsApiHelper;
import cn.qihangerp.open.wei.WeiWaybillAccountApiHelper;
import cn.qihangerp.open.wei.WeiWaybillApiHelper;
import cn.qihangerp.open.wei.bo.DeliveryProductInfo;
import cn.qihangerp.open.wei.bo.ewaybill.EcOrderInfo;
import cn.qihangerp.open.wei.bo.ewaybill.GoodsInfo;
import cn.qihangerp.open.wei.bo.ewaybill.SenderAddressBo;
import cn.qihangerp.open.wei.bo.ewaybill.WaybillRequest;
import cn.qihangerp.open.wei.vo.ewaybill.AccountVo;
import cn.qihangerp.open.wei.vo.ewaybill.EwaybillOrderCreateVo;
import com.alibaba.fastjson2.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import lombok.extern.java.Log;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Log
@RequestMapping("/shop/ewaybill")
@RestController
@AllArgsConstructor
public class ShopWayBillController extends BaseController {
    private final WeiApiCommon apiCommon;
    private final ShopWaybillAccountService waybillAccountService;
    private final ShopService shopService;

    /**
     * 获取电子面单账户
     * @param
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/get_waybill_account_list", method = RequestMethod.POST)
    public TableDataInfo getWaybillAccountList(ShopWaybillAccount bo, PageQuery pageQuery) throws Exception {
        bo.setTenantId(getUserId());
        PageResult<ShopWaybillAccount> pageList = waybillAccountService.queryPageList(bo, pageQuery);
        return getDataTable(pageList);
    }

    /**
     * 拉取电子面单账户
     * @param params
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pull_waybill_account", method = RequestMethod.POST)
    public AjaxResult pull_waybill_account(@RequestBody PullRequest params) throws Exception {
        if (params.getShopId() == null || params.getShopId() <= 0) {
            return AjaxResult.error( "参数错误，没有店铺Id");
        }
        Shop shop = shopService.getById(params.getShopId());
        if(shop==null) return AjaxResult.error("店铺不存在");

        Date currDateTime = new Date();
        long startTime = System.currentTimeMillis();
        if(shop.getType()==5) {
            var checkResult = apiCommon.checkBefore(params.getShopId());
            if (checkResult.getCode() != ResultVoEnum.SUCCESS.getIndex()) {
                return AjaxResult.error(checkResult.getCode(), checkResult.getMsg(), checkResult.getData());
            }
            String accessToken = checkResult.getData().getAccessToken();
            String appKey = checkResult.getData().getAppKey();
            String appSecret = checkResult.getData().getAppSecret();

            ApiResultVo<AccountVo> apiResultVo = WeiWaybillAccountApiHelper.getAccountList(appKey, appSecret, accessToken);
            if (apiResultVo.getCode() != 0) return AjaxResult.error(apiResultVo.getMsg());
            List<ShopWaybillAccount> list = new ArrayList<>();
            if (apiResultVo.getCode() == 0) {
                for (var item : apiResultVo.getList()) {
                    ShopWaybillAccount vo = new ShopWaybillAccount();
                    vo.setTenantId(shop.getTenantId());
                    vo.setShopId(params.getShopId());
                    vo.setShopType(shop.getType());
                    vo.setSellerShopId(Long.parseLong(item.getShopId()));
                    vo.setIsShow(1);
                    vo.setDeliveryId(item.getDeliveryId());
                    vo.setCompanyType(item.getCompanyType());
                    vo.setAcctId(item.getAcctId());
                    vo.setAcctType(item.getAcctType());
                    vo.setStatus(item.getStatus());
                    vo.setAvailable(item.getAvailable());
                    vo.setAllocated(item.getAllocated());
                    vo.setCancel(item.getCancel());
                    vo.setRecycled(item.getRecycled());
                    vo.setMonthlyCard(item.getMonthlyCard());
                    vo.setSiteInfo(JSONObject.toJSONString(item.getSiteInfo()));

                    if (item.getSenderAddress() != null) {
                        vo.setSenderAddress(item.getSenderAddress().getAddress());
                        vo.setSenderProvince(item.getSenderAddress().getProvince());
                        vo.setSenderCity(item.getSenderAddress().getCity());
                        vo.setSenderCounty(item.getSenderAddress().getCounty());
                    }
                    if (item.getSiteInfo() != null) {
                        vo.setSiteCode(item.getSiteInfo().getSiteCode());
                        vo.setSiteName(item.getSiteInfo().getSiteName());
                        vo.setSenderStreet(item.getSiteInfo().getAddress().getStreetName());
                    }
//                    List<OmsWeiLogisticsTemplate> logisticsCode = logisticsTemplateService.getByLogisticsCode(item.getDeliveryId());
//                    if (logisticsCode != null && logisticsCode.size() > 0) {
//                        vo.setTemplateUrl(logisticsCode.get(0).getUrl());
//                    }
                    list.add(vo);
//                waybillAccountService.saveAndUpdate(vo);
                }

                log.info("========同步wei电子面单账户信息==========");
                waybillAccountService.syncAccountList(params.getShopId(), list);
            }
        } else if (shop.getType()==3) {
            // 拼多多
            return AjaxResult.error("暂不支持");
        }else{
            return AjaxResult.error("不支持的平台");
        }


        return AjaxResult.success();
//        return AjaxResult.success(apiResultVo.getList());
    }

//    /**
//     * 取号
//     * @param req
//     * @return
//     */
//
//    @PostMapping("/get_waybill_code")
//    @ResponseBody
//    public AjaxResult getWaybillCode(@RequestBody WeiWaybillGetCodeBo req) {
//        if (req.getAccountId() == null || req.getAccountId() <= 0) {
//            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，请选择电子面单账户");
//        }
//        if (req.getIds() == null || req.getIds().length <= 0) {
//            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，没有选择订单");
//        }
//        int total = req.getIds().length;
//        int success = 0;
//        int fail = 0;
//        // 循环处理订单
//        for (Long id : req.getIds()) {
//            if (id != null) {
//                OSupplierShipOrder supplierShipOrder = supplierShipOrderService.getById(id);
//                if (supplierShipOrder != null && supplierShipOrder.getOrderStatus()==1) {
//                    String orderId = supplierShipOrder.getOrderNum();
//                    OmsWeiOrder order = orderService.queryDetailByOrderId(orderId);
//                    if (order != null && (order.getStatus()==20||order.getStatus()==21)) {
//                        var checkResult = apiCommon.checkBefore(order.getShopId());
//                        if (checkResult.getCode() != 0) {
//                            return AjaxResult.error(checkResult.getCode(), checkResult.getMsg(), checkResult.getData());
//                        }
//                        String accessToken = checkResult.getData().getAccessToken();
//                        String appKey = checkResult.getData().getAppKey();
//                        String appSecret = checkResult.getData().getAppSecret();
//
//                        // 获取电子面单账户信息(包含了发货地址信息)
//                        OmsWeiWaybillAccount account = waybillAccountService.getById(req.getAccountId());
//
//                        WaybillRequest apiBo = new WaybillRequest();
//                        if (account.getDeliveryId().equals("jd")) {
//                            apiBo.setOrder_type(3);
//                            apiBo.setRemark("托寄物：预制菜");
//                        }
//
//                        apiBo.setDelivery_id(account.getDeliveryId());
//                        apiBo.setEwaybill_acct_id(account.getAcctId());
//
//                        SenderAddressBo sender = new SenderAddressBo();
//                        sender.setName(account.getName());
//                        sender.setMobile(account.getMobile());
//                        sender.setProvince(account.getSenderProvince());
//                        sender.setCity(account.getSenderCity());
//                        sender.setCounty(account.getSenderCounty());
//                        sender.setStreet(account.getSenderStreet());
//                        sender.setAddress(account.getSenderAddress());
//                        apiBo.setSender(sender);
//                        SenderAddressBo receiver = new SenderAddressBo();
//                        receiver.setName(order.getUserName());
//                        receiver.setMobile(order.getTelNumber());
//                        receiver.setProvince(order.getProvinceName());
//                        receiver.setCity(order.getCityName());
//                        receiver.setCounty(order.getCountyName());
//                        receiver.setStreet("");
//                        receiver.setAddress("****");
//                        apiBo.setReceiver(receiver);
//
//                        List<EcOrderInfo> orderInfos = new ArrayList<>();
//                        // 订单信息
//                        EcOrderInfo orderInfo = new EcOrderInfo();
//                        orderInfo.setEc_order_id(Long.parseLong(order.getOrderId()));
//
//                        List<GoodsInfo> goodsInfos = new ArrayList<>();
//                        if (order.getItems() != null && order.getItems().size() > 0) {
//                            for (var item : order.getItems()) {
//                                if(item.getRefundStatus()==1) {
//                                    GoodsInfo gi = new GoodsInfo();
//                                    gi.setProduct_id(Long.parseLong(item.getProductId()));
//                                    gi.setSku_id(Long.parseLong(item.getSkuId()));
//                                    gi.setGood_name(item.getTitle());
//                                    gi.setGood_count(item.getSkuCnt());
//                                    goodsInfos.add(gi);
//                                }
//                            }
//
//                        }
//
//                        orderInfo.setGoods_list(goodsInfos);
//                        orderInfos.add(orderInfo);
//
//                        apiBo.setEc_order_list(orderInfos);
//
//                        apiBo.setShop_id(account.getSellerShopId().toString());
//
//                        ApiResultVo<EwaybillOrderCreateVo> apiResultVo = WeiWaybillApiHelper.getWaybillCode(appKey, appSecret, accessToken, apiBo);
//                        if (apiResultVo.getCode() == 0) {
//                            // 保持数据
//                            supplierShipOrder.setWaybillCode(apiResultVo.getData().getWaybill_id());
//                            supplierShipOrder.setWaybillCompany(account.getDeliveryId());
//                            supplierShipOrder.setPrintData(apiResultVo.getData().getPrint_info());
//                            supplierShipOrder.setWaybillOrderId(apiResultVo.getData().getEwaybill_order_id());
//
////                            waybill.setWaybillCode(apiResultVo.getData().getWaybill_id());
////                            waybill.setLogisticsCode(account.getDeliveryId());
////                            waybill.setPrintData(apiResultVo.getData().getPrint_info());
////                            waybill.setStatus(1);//1已取号
////                            waybill.setWaybillOrderId(apiResultVo.getData().getEwaybill_order_id());
//
//                            ResultVo<Long> resultVo = erpShipWaybillService.updateWaybillCode(supplierShipOrder,account.getTemplateUrl(),3);
//                            if(resultVo.getCode()==0) success++;
//                            else fail++;
//                        } else {
//                            return AjaxResult.error(apiResultVo.getMsg());
//                        }
//                    }else {
//                        return AjaxResult.error("没有找到原始订单");
//                    }
//                }
//            }
//        }
//        return AjaxResult.success();
//    }
//
//    /**
//     * 取号并发货
//     * @param req
//     * @return
//     */
//    @PostMapping("/get_waybill_code_and_send")
//    @ResponseBody
//    public AjaxResult getWaybillCodeAndSend(@RequestBody WeiWaybillGetCodeBo req) {
//        if (req.getAccountId() == null || req.getAccountId() <= 0) {
//            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，请选择电子面单账户");
//        }
//        if (req.getIds() == null || req.getIds().length <= 0) {
//            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，没有选择订单");
//        }
//
//        // 获取电子面单账户信息(包含了发货地址信息)
//        OmsWeiWaybillAccount waybillAccount = waybillAccountService.getById(req.getAccountId());
//        if (waybillAccount == null) return AjaxResult.error("电子面单账号不存在");
//
//        int total = req.getIds().length;
//        int success = 0;
//        int fail = 0;
//        int isSend = 0;
//        WeiWaybillCodeVo vo = new WeiWaybillCodeVo();
//        vo.setTotal(total);
//        for (Long id : req.getIds()) {
//            if (id == null || id <= 0) {
//                fail++;
//                continue;
//            }
//
//            // 获取供应商发货订单信息
//            OSupplierShipOrder supplierShipOrder = supplierShipOrderService.getById(id);
//            if (supplierShipOrder == null) {
//                fail++;//发货订单不存在
//                continue;
//            }
//            else if (supplierShipOrder.getOrderStatus() != 1) {
//                isSend++;//订单已发货
//                continue;
//            }
//            else if (supplierShipOrder.getWaybillStatus() != 0){
//                isSend ++;//订单已取号
//                continue;
//            }
//
//
//            OmsWeiOrder order = orderService.queryDetailByOrderId(supplierShipOrder.getOrderNum());
//            if (order == null) {
//                fail++;//原始订单不存在
//                continue;
//            }
//            else if (order.getStatus().intValue() != 20 && order.getStatus() != 21) {
//                isSend++;//订单状态不允许再发货
//                continue;
//            }
//
//            var checkResult = apiCommon.checkBefore(order.getShopId());
//            if (checkResult.getCode() != 0) {
//                fail++;
//                log.info("获取token错误");
//                continue;
//            }
//            String accessToken = checkResult.getData().getAccessToken();
//            String appKey = checkResult.getData().getAppKey();
//            String appSecret = checkResult.getData().getAppSecret();
//
//            WaybillRequest apiBo = new WaybillRequest();
//            if (waybillAccount.getDeliveryId().toLowerCase().equals("jd")) {
//                apiBo.setOrder_type(3);
//                apiBo.setRemark("托寄物：预制菜");
//            }
//
//            apiBo.setDelivery_id(waybillAccount.getDeliveryId());
//            apiBo.setEwaybill_acct_id(waybillAccount.getAcctId());
//
//            SenderAddressBo sender = new SenderAddressBo();
//            sender.setName(waybillAccount.getName());
//            sender.setMobile(waybillAccount.getMobile());
//            sender.setProvince(waybillAccount.getSenderProvince());
//            sender.setCity(waybillAccount.getSenderCity());
//            sender.setCounty(waybillAccount.getSenderCounty());
//            sender.setStreet(waybillAccount.getSenderStreet());
//            sender.setAddress(waybillAccount.getSenderAddress());
//            apiBo.setSender(sender);
//
//            // 订单收件人
//            SenderAddressBo receiver = new SenderAddressBo();
//            receiver.setName(order.getUserName());
//            receiver.setMobile(order.getTelNumber());
//            receiver.setProvince(order.getProvinceName());
//            receiver.setCity(order.getCityName());
//            receiver.setCounty(order.getCountyName());
//            receiver.setStreet("");
//            receiver.setAddress("****");
//            apiBo.setReceiver(receiver);
//
//            List<EcOrderInfo> orderInfos = new ArrayList<>();
//            // 订单信息
//            EcOrderInfo orderInfo = new EcOrderInfo();
//            orderInfo.setEc_order_id(Long.parseLong(order.getOrderId()));
//
//            //取号参数
//            List<GoodsInfo> goodsInfos = new ArrayList<>();
//
//            // 发货参数
//            List<DeliveryProductInfo> productInfoList = new ArrayList<>();
//            //组合参数
//            List<OSupplierShipOrderItem> items = supplierShipOrderService.getItemsByOrderId(supplierShipOrder.getId());
//            if (items != null && items.size() > 0) {
//                for (var it : items) {
//                    if (it.getRefundStatus() == 1) {
//                        GoodsInfo gi = new GoodsInfo();
//                        gi.setProduct_id(Long.parseLong(it.getProductId()));
//                        gi.setSku_id(Long.parseLong(it.getSkuId()));
//                        gi.setGood_name(it.getGoodsName());
//                        gi.setGood_count(it.getQuantity());
//                        goodsInfos.add(gi);
//                        // 发货参数
//                        DeliveryProductInfo info = new DeliveryProductInfo();
//                        info.setProduct_cnt(it.getQuantity());
//                        info.setProduct_id(it.getProductId());
//                        info.setSku_id(it.getSkuId());
//                        productInfoList.add(info);
//                    }
//                }
//
//            }
//
//            orderInfo.setGoods_list(goodsInfos);
//            orderInfos.add(orderInfo);
//            apiBo.setEc_order_list(orderInfos);
//            apiBo.setShop_id(waybillAccount.getSellerShopId().toString());
//
//            ApiResultVo<EwaybillOrderCreateVo> apiResultVo = WeiWaybillApiHelper.getWaybillCode(appKey, appSecret, accessToken, apiBo);
//            if (apiResultVo.getCode() == 0) {
//                // 保持数据
//                supplierShipOrder.setWaybillCode(apiResultVo.getData().getWaybill_id());
//                supplierShipOrder.setWaybillCompany(waybillAccount.getDeliveryId());
//                supplierShipOrder.setPrintData(apiResultVo.getData().getPrint_info());
//                supplierShipOrder.setWaybillOrderId(apiResultVo.getData().getEwaybill_order_id());
//
//                ResultVo<Long> resultVo = erpShipWaybillService.updateWaybillCode(supplierShipOrder, waybillAccount.getTemplateUrl(), 3);
//                if (resultVo.getCode() == 0) {
//                    ApiResultVo<JSONObject> sendResult = WeiLogisticsApiHelper.pushDeliverySend(accessToken, supplierShipOrder.getOrderNum(), waybillAccount.getDeliveryId(), apiResultVo.getData().getWaybill_id(), productInfoList);
//                    if (sendResult.getCode() == 0) success++;
//                    else fail++;
//                    log.info("==========weishop发货结果==========" + JSONObject.toJSONString(apiResultVo));
//                } else fail++;
//            } else {
//                fail++;//取号失败
//            }
//        }
//
//        String result = "发货结果：总计：" + total + " 成功：" + success + " 失败：" + fail + " 已发货：" + isSend;
//        log.info(result);
//        vo.setFail(fail);
//        vo.setSuccess(success);
//        vo.setIsSend(isSend);
//        return AjaxResult.success(vo);
//    }
//
//
//    /**
//     * 取消取号
//     * @param req
//     * @return
//     */
//    @PostMapping("/cancel_waybill_code")
//    @ResponseBody
//    public AjaxResult getPrintData(@RequestBody WeiWaybillGodeCancelBo req) {
//
//        ResultVo<OShipWaybill> resultVo = erpShipWaybillService.cancelWaybillCode(req.getId(), req.getOrderNum());
//        if(resultVo.getCode()==0){
//            var checkResult = apiCommon.checkBefore(resultVo.getData().getShopId());
//            if (checkResult.getCode() != 0) {
//                return AjaxResult.error(checkResult.getCode(), checkResult.getMsg(), checkResult.getData());
//            }
//            String accessToken = checkResult.getData().getAccessToken();
//            String appKey = checkResult.getData().getAppKey();
//            String appSecret = checkResult.getData().getAppSecret();
//            ApiResultVo<String> stringApiResultVo = WeiWaybillApiHelper.waybillCodeCancel(accessToken, resultVo.getData().getWaybillOrderId(), resultVo.getData().getLogisticsCode(), resultVo.getData().getWaybillCode());
//            String s="";
//        }
//        return AjaxResult.success();
//    }
//
//    @PostMapping("/get_print_data")
//    @ResponseBody
//    public AjaxResult getPrintData(@RequestBody WeiWaybillGetBo req) {
//        if (req.getIds() == null || req.getIds().length <= 0) {
//            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，没有选择订单");
//        }
//        List<OShipWaybill> listByOrderIds = erpShipWaybillService.getListBySupplierShipOrderIds(req.getIds());
//        return AjaxResult.success(listByOrderIds);
//    }
//
//    @PostMapping("/push_print_success")
//    @ResponseBody
//    public AjaxResult pushPrintSuccess(@RequestBody WeiWaybillGetBo req) {
//        if (req.getIds() == null || req.getIds().length <= 0) {
//            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，没有选择订单");
//        }
//        int total  = req.getIds().length;
//        int success =0;
//        int fail = 0;
//        for (String id:req.getIds()) {
//            ResultVo<Integer> resultVo = erpShipWaybillService.supplierPrintSuccess(id);
//            if (resultVo.getCode() == 0) success++;
//            else fail++;
//        }
//        String msg ="打印订单，总数："+total+ " 成功："+success+" 失败："+fail;
//        log.info(msg);
//        return AjaxResult.success(msg);
//    }
//
//    /**
//     * 发货
//     * @param req
//     * @return
//     */
//    @PostMapping("/push_ship_send")
//    @ResponseBody
//    public AjaxResult pushShipSend(@RequestBody WeiWaybillGetBo req) {
//        if (req.getIds() == null || req.getIds().length <= 0) {
//            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，没有选择订单");
//        }
//        int total  = req.getIds().length;
//        int success =0;
//        int fail = 0;
//        for (String id:req.getIds()) {
//            ResultVo<Integer> resultVo = erpShipWaybillService.pushSupplierShipSend(id);
//            if (resultVo.getCode() == 0) success++;
//            else fail++;
//        }
//
//        String msg ="订单发货，总数："+total+ " 成功："+success+" 失败："+fail;
//        log.info(msg);
//        return AjaxResult.success(msg);
//    }
}
