package cn.qihangerp.api.controller.shop;

import cn.qihangerp.api.common.*;
import cn.qihangerp.api.common.utils.NumberUtils;
import cn.qihangerp.api.domain.*;
import cn.qihangerp.api.request.ShopWaybillGetCodeBo;
import cn.qihangerp.api.request.ShopWaybillAccountUpdateRequest;
import cn.qihangerp.api.service.*;
import cn.qihangerp.api.vo.ShopWaybillCodeVo;
import cn.qihangerp.open.common.ApiResultVo;
import cn.qihangerp.open.pdd.PddLogisticsApiHelper;
import cn.qihangerp.open.pdd.PddWaybillAccountApiHelper;
import cn.qihangerp.open.pdd.PddWaybillApiHelper;
import cn.qihangerp.open.pdd.model.Order;
import cn.qihangerp.open.pdd.model.WaybillAccount;
import cn.qihangerp.open.pdd.model.WaybillCodeModule;
import cn.qihangerp.open.pdd.request.*;
import cn.qihangerp.open.wei.WeiWaybillAccountApiHelper;
import cn.qihangerp.open.wei.vo.ewaybill.AccountVo;
import com.alibaba.fastjson2.JSONObject;
import lombok.AllArgsConstructor;
import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.*;

@Slf4j
@RequestMapping("/shop/ewaybill")
@RestController
@AllArgsConstructor
public class ShopWayBillController extends BaseController {
    private final WeiApiCommon apiCommon;
    private final PddApiCommon pddApiCommon;
    private final ShopWaybillAccountService waybillAccountService;
    private final ShopService shopService;
    private final ErpOrderService orderService;
    private final ErpOrderShipWaybillService orderShipWaybillService;
    private final ErpLogisticsCompanyService erpLogisticsCompanyService;
    /**
     * 获取电子面单账户
     * @param
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/get_waybill_account_list", method = RequestMethod.GET)
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
            var checkResult = pddApiCommon.checkBefore(params.getShopId());
            if (checkResult.getCode() != ResultVoEnum.SUCCESS.getIndex()) {
                return AjaxResult.error(500, checkResult.getMsg());
            }
            String accessToken = checkResult.getData().getAccessToken();
            String appKey = checkResult.getData().getAppKey();
            String appSecret = checkResult.getData().getAppSecret();
            ApiResultVo<WaybillAccount> apiResultVo = PddWaybillAccountApiHelper.pullWaybillBranchAccountList(appKey, appSecret, accessToken);
            if (apiResultVo.getCode() == 10019) return AjaxResult.error(1401, apiResultVo.getMsg());
            else if (apiResultVo.getCode() != 0) return AjaxResult.error(apiResultVo.getCode(), apiResultVo.getMsg());
            List<ShopWaybillAccount> list = new ArrayList<>();
            for (var item : apiResultVo.getList()) {

                for(var it:item.getBranchAccountCols()) {
                    ShopWaybillAccount vo = new ShopWaybillAccount();
                    vo.setTenantId(shop.getTenantId());
                    vo.setShopId(params.getShopId());
                    vo.setShopType(shop.getType());
                    vo.setIsShow(1);
                    vo.setDeliveryId(item.getWpCode());
                    vo.setCompanyType(item.getWpType());

//                    vo.setAcctId(item.getAcctId());
//                    vo.setAcctType(item.getAcctType());
                    vo.setStatus(1);
                    vo.setSiteCode(it.getBranchCode());
                    vo.setSiteName(it.getBranchName());
                    vo.setAvailable(it.getQuantity());
                    vo.setAllocated(it.getAllocatedQuantity());//累积已取单
                    vo.setCancel(it.getCancelQuantity());//累计已取消
                    vo.setRecycled(it.getRecycledQuantity());//累积已回收
                    vo.setMonthlyCard("");
                    vo.setSiteInfo(JSONObject.toJSONString(it.getShippAddressCols()));

                    if (it.getShippAddressCols() != null) {
                        vo.setSenderAddress(it.getShippAddressCols().get(0).getDetail());
                        vo.setSenderProvince(it.getShippAddressCols().get(0).getProvince());
                        vo.setSenderCity(it.getShippAddressCols().get(0).getCity());
                        vo.setSenderCounty(it.getShippAddressCols().get(0).getDistrict());
                    }
//                    List<OmsWeiLogisticsTemplate> logisticsCode = logisticsTemplateService.getByLogisticsCode(item.getDeliveryId());
//                    if (logisticsCode != null && logisticsCode.size() > 0) {
//                        vo.setTemplateUrl(logisticsCode.get(0).getUrl());
//                    }
                    list.add(vo);
                }
            }

            log.info("========同步pdd电子面单账户信息==========");
            waybillAccountService.syncAccountList(params.getShopId(), list);

            return AjaxResult.success();
        }else{
            return AjaxResult.error("不支持的平台");
        }


        return AjaxResult.success();
//        return AjaxResult.success(apiResultVo.getList());
    }

    @RequestMapping(value = "/updateAccount", method = RequestMethod.POST)
    public AjaxResult updateAccount(@RequestBody ShopWaybillAccountUpdateRequest params) throws Exception {
        if (params.getId() == null || params.getId() <= 0) return AjaxResult.error("参数错误，没有Id");
        if (!StringUtils.hasText(params.getName())) return AjaxResult.error("缺少参数");
        if (!StringUtils.hasText(params.getMobile())) return AjaxResult.error("缺少参数");
        if (!StringUtils.hasText(params.getSiteName())) return AjaxResult.error("缺少参数");
        if (!StringUtils.hasText(params.getSiteCode())) return AjaxResult.error("缺少参数");

        ShopWaybillAccount account = new ShopWaybillAccount();
        account.setId(params.getId());
        account.setSiteName(params.getSiteName());
        account.setSiteCode(params.getSiteCode());
        account.setName(params.getName());
        account.setMobile(params.getMobile());
        account.setSellerShopId(Long.parseLong(params.getSellerShopId()));
        waybillAccountService.updateById(account);

        return AjaxResult.success();
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
    /**
     * 取号并发货
     * @param req
     * @return
     */
    @PostMapping("/get_waybill_code_and_send")
    @ResponseBody
    public AjaxResult getWaybillCodeAndSend(@RequestBody ShopWaybillGetCodeBo req) throws IOException {
        if (req.getAccountId() == null || req.getAccountId() <= 0) {
            return AjaxResult.error( "参数错误，请选择电子面单账户");
        }
        if (req.getShopId() == null || req.getShopId() <= 0) {
            return AjaxResult.error( "参数错误，没有选择店铺");
        }
        if (req.getIds() == null || req.getIds().length <= 0) {
            return AjaxResult.error( "参数错误，没有选择订单");
        }

        // 获取电子面单账户信息(包含了发货地址信息)
        ShopWaybillAccount waybillAccount = waybillAccountService.getById(req.getAccountId());
        if (waybillAccount == null) return AjaxResult.error("电子面单账号不存在");

        Shop shop = shopService.getById(req.getShopId());
        if(shop==null) return AjaxResult.error("店铺不存在");

        int total = req.getIds().length;
        int success = 0;
        int fail = 0;
        int isSend = 0;
        ShopWaybillCodeVo vo = new ShopWaybillCodeVo();
        vo.setTotal(total);
        if(shop.getType()==5) {
            var checkResult = apiCommon.checkBefore(req.getShopId());
            if (checkResult.getCode() != 0) {
                log.info("获取token错误");
                return AjaxResult.error(checkResult.getMsg());
            }
            String accessToken = checkResult.getData().getAccessToken();
            String appKey = checkResult.getData().getAppKey();
            String appSecret = checkResult.getData().getAppSecret();

//            for (Long id : req.getIds()) {
//                if (id == null || id <= 0) {
//                    fail++;
//                    continue;
//                }
//                // 获取供应商发货订单信息
//                OSupplierShipOrder supplierShipOrder = supplierShipOrderService.getById(id);
//                if (supplierShipOrder == null) {
//                    fail++;//发货订单不存在
//                    continue;
//                } else if (supplierShipOrder.getOrderStatus() != 1) {
//                    isSend++;//订单已发货
//                    continue;
//                } else if (supplierShipOrder.getWaybillStatus() != 0) {
//                    isSend++;//订单已取号
//                    continue;
//                }
//
//
//                OmsWeiOrder order = orderService.queryDetailByOrderId(supplierShipOrder.getOrderNum());
//                if (order == null) {
//                    fail++;//原始订单不存在
//                    continue;
//                } else if (order.getStatus().intValue() != 20 && order.getStatus() != 21) {
//                    isSend++;//订单状态不允许再发货
//                    continue;
//                }
//
//
//
//                WaybillRequest apiBo = new WaybillRequest();
//                if (waybillAccount.getDeliveryId().toLowerCase().equals("jd")) {
//                    apiBo.setOrder_type(3);
//                    apiBo.setRemark("托寄物：预制菜");
//                }
//
//                apiBo.setDelivery_id(waybillAccount.getDeliveryId());
//                apiBo.setEwaybill_acct_id(waybillAccount.getAcctId());
//
//                SenderAddressBo sender = new SenderAddressBo();
//                sender.setName(waybillAccount.getName());
//                sender.setMobile(waybillAccount.getMobile());
//                sender.setProvince(waybillAccount.getSenderProvince());
//                sender.setCity(waybillAccount.getSenderCity());
//                sender.setCounty(waybillAccount.getSenderCounty());
//                sender.setStreet(waybillAccount.getSenderStreet());
//                sender.setAddress(waybillAccount.getSenderAddress());
//                apiBo.setSender(sender);
//
//                // 订单收件人
//                SenderAddressBo receiver = new SenderAddressBo();
//                receiver.setName(order.getUserName());
//                receiver.setMobile(order.getTelNumber());
//                receiver.setProvince(order.getProvinceName());
//                receiver.setCity(order.getCityName());
//                receiver.setCounty(order.getCountyName());
//                receiver.setStreet("");
//                receiver.setAddress("****");
//                apiBo.setReceiver(receiver);
//
//                List<EcOrderInfo> orderInfos = new ArrayList<>();
//                // 订单信息
//                EcOrderInfo orderInfo = new EcOrderInfo();
//                orderInfo.setEc_order_id(Long.parseLong(order.getOrderId()));
//
//                //取号参数
//                List<GoodsInfo> goodsInfos = new ArrayList<>();
//
//                // 发货参数
//                List<DeliveryProductInfo> productInfoList = new ArrayList<>();
//                //组合参数
//                List<OSupplierShipOrderItem> items = supplierShipOrderService.getItemsByOrderId(supplierShipOrder.getId());
//                if (items != null && items.size() > 0) {
//                    for (var it : items) {
//                        if (it.getRefundStatus() == 1) {
//                            GoodsInfo gi = new GoodsInfo();
//                            gi.setProduct_id(Long.parseLong(it.getProductId()));
//                            gi.setSku_id(Long.parseLong(it.getSkuId()));
//                            gi.setGood_name(it.getGoodsName());
//                            gi.setGood_count(it.getQuantity());
//                            goodsInfos.add(gi);
//                            // 发货参数
//                            DeliveryProductInfo info = new DeliveryProductInfo();
//                            info.setProduct_cnt(it.getQuantity());
//                            info.setProduct_id(it.getProductId());
//                            info.setSku_id(it.getSkuId());
//                            productInfoList.add(info);
//                        }
//                    }
//
//                }
//
//                orderInfo.setGoods_list(goodsInfos);
//                orderInfos.add(orderInfo);
//                apiBo.setEc_order_list(orderInfos);
//                apiBo.setShop_id(waybillAccount.getSellerShopId().toString());
//
//                ApiResultVo<EwaybillOrderCreateVo> apiResultVo = WeiWaybillApiHelper.getWaybillCode(appKey, appSecret, accessToken, apiBo);
//                if (apiResultVo.getCode() == 0) {
//                    // 保持数据
//                    supplierShipOrder.setWaybillCode(apiResultVo.getData().getWaybill_id());
//                    supplierShipOrder.setWaybillCompany(waybillAccount.getDeliveryId());
//                    supplierShipOrder.setPrintData(apiResultVo.getData().getPrint_info());
//                    supplierShipOrder.setWaybillOrderId(apiResultVo.getData().getEwaybill_order_id());
//
//                    ResultVo<Long> resultVo = erpShipWaybillService.updateWaybillCode(supplierShipOrder, waybillAccount.getTemplateUrl(), 3);
//                    if (resultVo.getCode() == 0) {
//                        ApiResultVo<JSONObject> sendResult = WeiLogisticsApiHelper.pushDeliverySend(accessToken, supplierShipOrder.getOrderNum(), waybillAccount.getDeliveryId(), apiResultVo.getData().getWaybill_id(), productInfoList);
//                        if (sendResult.getCode() == 0) success++;
//                        else fail++;
//                        log.info("==========weishop发货结果==========" + JSONObject.toJSONString(apiResultVo));
//                    } else fail++;
//                } else {
//                    fail++;//取号失败
//                }
//            }
        }else if (shop.getType()==3) {
            // 拼多多
            var checkResult = pddApiCommon.checkBefore(req.getShopId());
            if (checkResult.getCode() != ResultVoEnum.SUCCESS.getIndex()) {
                return AjaxResult.error(500, checkResult.getMsg());
            }
            String accessToken = checkResult.getData().getAccessToken();
            String appKey = checkResult.getData().getAppKey();
            String appSecret = checkResult.getData().getAppSecret();

            WaybillCloudPrintApplyNewRequest cloudPrintRequest = new WaybillCloudPrintApplyNewRequest();
            cloudPrintRequest.setWp_code(waybillAccount.getDeliveryId());
            cloudPrintRequest.setNeed_encrypt(false);
            // 发货联系人
            WaybillCloudPrintApplyNewRequestContact contact = new WaybillCloudPrintApplyNewRequestContact();
            WaybillCloudPrintApplyNewRequestContactAddress senderAddress = new WaybillCloudPrintApplyNewRequestContactAddress();
            senderAddress.setProvince(waybillAccount.getSenderProvince());
            senderAddress.setCity(waybillAccount.getSenderCity());
            senderAddress.setDistrict(waybillAccount.getSenderCounty());
            senderAddress.setDetail(waybillAccount.getSenderAddress());
            contact.setAddress(senderAddress);
            contact.setName(waybillAccount.getName());
            contact.setMobile(waybillAccount.getMobile());

            cloudPrintRequest.setSender(contact);


            List<WaybillCloudPrintApplyNewRequestTradeOrderInfoDto> tradeOrderList = new ArrayList<>();

            for (Long id : req.getIds()) {
                if (id == null || id <= 0) {
                    fail++;
                    continue;
                }
                ErpOrder erpOrder = orderService.queryDetailById(id);
                if(erpOrder!=null){
                    OrderInfo orderInfo = new OrderInfo();
                    orderInfo.setOrder_channels_type("PDD");
                    orderInfo.setTrade_order_list(new String[]{erpOrder.getOrderNum()});
                    PackageInfo packageInfo = new PackageInfo();

                    List<PackageInfoItem> items = new ArrayList<>();
                    for (var orderItem :erpOrder.getItemList()) {
                        PackageInfoItem packageInfoItem = new PackageInfoItem();
                        packageInfoItem.setName(orderItem.getGoodsTitle());
                        packageInfoItem.setCount(orderItem.getQuantity());
                        items.add(packageInfoItem);
                    }
                    packageInfo.setItems(items);

                    WaybillCloudPrintApplyNewRequestContact recipient = new WaybillCloudPrintApplyNewRequestContact();
                    recipient.setName(erpOrder.getReceiverName());
                    recipient.setMobile("-");
                    WaybillCloudPrintApplyNewRequestContactAddress recipientAddress = new WaybillCloudPrintApplyNewRequestContactAddress();
                    recipientAddress.setProvince(erpOrder.getProvince());
                    recipientAddress.setCity(erpOrder.getCity());
                    recipientAddress.setDistrict(erpOrder.getTown());
                    recipientAddress.setDetail(erpOrder.getAddress());
                    recipient.setAddress(recipientAddress);

                    WaybillCloudPrintApplyNewRequestTradeOrderInfoDto orderInfoDto = new WaybillCloudPrintApplyNewRequestTradeOrderInfoDto();
                    orderInfoDto.setObject_id(erpOrder.getOrderNum());
                    orderInfoDto.setOrder_info(orderInfo);
                    orderInfoDto.setPackage_info(packageInfo);
                    orderInfoDto.setRecipient(recipient);
                    orderInfoDto.setUser_id(0L);
//                    orderInfoDto.setUser_id(shop.getSellerId());
                    orderInfoDto.setTemplate_url(waybillAccount.getTemplateUrl());
                    tradeOrderList.add(orderInfoDto);
                }

            }

            // 取号订单信息
            cloudPrintRequest.setTrade_order_info_dtos(tradeOrderList);

            ApiResultVo<WaybillCodeModule> apiResultVo = PddWaybillApiHelper.getWaybillCode(appKey, appSecret, accessToken,cloudPrintRequest);
            if (apiResultVo.getCode() == 10019) return AjaxResult.error(1401, apiResultVo.getMsg());
            else if (apiResultVo.getCode() != 0) return AjaxResult.error(apiResultVo.getCode(), apiResultVo.getMsg());
            // 循环list
            for(var item :apiResultVo.getList()){
                // 添加打印数据到数据库
                ResultVo resultVo = orderShipWaybillService.saveWaybill(item.getObject_id(), item.getWaybill_code(), waybillAccount.getDeliveryId(), item.getPrint_data());
                log.info("=======获取电子面单成功======添加电子面单数据到数据库======={}",JSONObject.toJSONString(resultVo));
                // 发货操作
                ErpLogisticsCompany erpLogisticsCompany = erpLogisticsCompanyService.queryByCode(waybillAccount.getDeliveryId(), shop.getType());
                if(erpLogisticsCompany!=null){
                    log.info("=====发货参数======logisticsId:{},orderNum:{},shipNo:{}",erpLogisticsCompany.getLogisticsId(),item.getObject_id(),item.getWaybill_code());
                    ApiResultVo sendApi = PddLogisticsApiHelper.onlineSend(appKey, appSecret, accessToken, erpLogisticsCompany.getLogisticsId(), item.getObject_id(),item.getWaybill_code());
                    log.info("=====发货结果======{}", JSONObject.toJSONString(sendApi));
                }else{
                    log.error("=========没有找到快递公司信息=====无法发货===========");
                }

            }
        }

        String result = "发货结果：总计：" + total + " 成功：" + success + " 失败：" + fail + " 已发货：" + isSend;
        log.info(result);
        vo.setFail(fail);
        vo.setSuccess(success);
        vo.setIsSend(isSend);
        return AjaxResult.success(vo);
    }


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

    @PostMapping("/get_print_data")
    @ResponseBody
    public AjaxResult getPrintData(@RequestBody ShopWaybillGetCodeBo req) {
        if (req.getIds() == null || req.getIds().length <= 0) {
            return AjaxResult.error("参数错误，没有选择订单");
        }
        List<ErpOrderShipWaybill> listByOrderIds = orderShipWaybillService.queryListByErpOrderId(req.getIds());
        return AjaxResult.success(listByOrderIds);
    }

    /***
     * 打印成功回调
     * @param req
     * @return
     */
    @PostMapping("/push_print_success")
    @ResponseBody
    public AjaxResult pushPrintSuccess(@RequestBody ShopWaybillGetCodeBo req) {
        if (req.getIds() == null || req.getIds().length <= 0) {
            return AjaxResult.error( "参数错误，没有选择订单");
        }
        int total  = req.getIds().length;
        int success =0;
        int fail = 0;
//        for (String id:req.getIds()) {
//            ResultVo<Integer> resultVo = erpShipWaybillService.supplierPrintSuccess(id);
//            if (resultVo.getCode() == 0) success++;
//            else fail++;
//        }
        String msg ="打印订单，总数："+total+ " 成功："+success+" 失败："+fail;
        log.info(msg);
        return AjaxResult.success(msg);
    }
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
