package cn.qihangerp.api.controller.shop;

import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.common.enums.EnumShopType;
import cn.qihangerp.api.domain.ErpShopPullLogs;
import cn.qihangerp.api.domain.Shop;
import cn.qihangerp.api.domain.ShopGoods;
import cn.qihangerp.api.domain.ShopGoodsSku;
import cn.qihangerp.api.service.ErpShopPullLogsService;
import cn.qihangerp.api.service.ShopGoodsService;
import cn.qihangerp.api.service.ShopService;
import cn.qihangerp.open.common.ApiResultVo;
import cn.qihangerp.open.pdd.PddGoodsApiHelper;
import cn.qihangerp.open.pdd.model.GoodsResultVo;
import cn.qihangerp.open.wei.WeiGoodsApiService;
import cn.qihangerp.open.wei.model.Product;
import com.alibaba.fastjson2.JSONObject;

import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import cn.qihangerp.api.common.AjaxResult;
import cn.qihangerp.api.common.ResultVoEnum;
import cn.qihangerp.api.common.enums.HttpStatus;


import java.util.*;

@RequestMapping("/shop/goods")
@RestController
@AllArgsConstructor
public class GoodsApiController extends BaseController {
    private final WeiApiCommon weiApiCommon;
    private final PddApiCommon pddApiCommon;
    private final ShopService shopService;
    private final ShopGoodsService shopGoodsService;
    private final WeiGoodsApiService goodsApiService;
    private final ErpShopPullLogsService pullLogsService;

    @RequestMapping(value = "/pull_list", method = RequestMethod.POST)
    public AjaxResult pullList(@RequestBody PullRequest params) throws Exception {
        if (params.getShopId() == null || params.getShopId() <= 0) {
//            return ApiResul new ApiResult(HttpStatus.PARAMS_ERROR, "参数错误，没有店铺Id");
            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，没有店铺Id");
        }
        Shop shop = shopService.getById(params.getShopId());
        if(shop==null) return AjaxResult.error("店铺不存在");

        Date currDateTime = new Date();
        long beginTime = System.currentTimeMillis();
        int total = 0;
        int insert = 0;
        int update = 0;
        int fail = 0;

        if(shop.getType()==5) {
            var checkResult = weiApiCommon.checkBefore(params.getShopId());
            if (checkResult.getCode() != ResultVoEnum.SUCCESS.getIndex()) {
//            return AjaxResult.error(checkResult.getCode(), checkResult.getMsg(), checkResult.getData());
                ErpShopPullLogs logs = new ErpShopPullLogs();
                logs.setTenantId(getUserId());
                logs.setShopType(EnumShopType.WEI.getIndex());
                logs.setShopId(params.getShopId());
                logs.setPullType("GOODS");
                logs.setPullWay("主动拉取");
                logs.setPullParams("{status:5}");
                logs.setPullResult("{insert:0,update:0,fail:0}");
                logs.setPullTime(currDateTime);
                logs.setDuration(System.currentTimeMillis() - beginTime);
                pullLogsService.save(logs);
                return AjaxResult.error(checkResult.getMsg());
            }
            String accessToken = checkResult.getData().getAccessToken();
//            String serverUrl = checkResult.getData().getApiRequestUrl();
            String appKey = checkResult.getData().getAppKey();
            String appSecret = checkResult.getData().getAppSecret();

            ApiResultVo<Product> productApiResultVo = goodsApiService.pullGoodsList(accessToken);
            if (productApiResultVo.getCode() == 0) {
                // 成功
                for (var product : productApiResultVo.getList()) {
                    total++;
                    ShopGoods goods = new ShopGoods();
                    goods.setTenantId(getUserId());
                    goods.setShopId(params.getShopId());
                    goods.setShopType(shop.getType());
                    goods.setProductId(product.getProduct_id());
                    goods.setOutProductId(product.getOut_product_id());
                    goods.setTitle(product.getTitle());
                    goods.setSubTitle(product.getSub_title());
                    goods.setHeadImg(product.getHead_imgs().getString(0));
                    goods.setHeadImgs(JSONObject.toJSONString(product.getHead_imgs()));
                    goods.setDescInfo(JSONObject.toJSONString(product.getDesc_info()));
                    goods.setAttrs(JSONObject.toJSONString(product.getAttrs()));
                    goods.setStatus(product.getStatus());
                    goods.setEditStatus(product.getEdit_status());
                    goods.setMinPrice(product.getMin_price());
                    goods.setSpuCode(product.getSpu_code());
                    goods.setProductType(product.getProduct_type());
                    goods.setEditTime(product.getEdit_time());
                    goods.setQuantity(0);
                    List<ShopGoodsSku> skuList = new ArrayList<>();
                    for (var sku : product.getSkus()) {
                        ShopGoodsSku goodsSku = new ShopGoodsSku();
                        goodsSku.setTenantId(goods.getTenantId());
                        goodsSku.setShopId(goods.getShopId());
                        goodsSku.setShopType(shop.getType());
                        goodsSku.setQuantity(sku.getStock_num());
                        goodsSku.setSkuId(sku.getSku_id());
                        goodsSku.setProductId(product.getProduct_id());
                        goodsSku.setOutSkuId(sku.getOut_sku_id());
                        goodsSku.setThumbImg(sku.getThumb_img());
                        if (StringUtils.isBlank(goodsSku.getThumbImg())) {
                            goodsSku.setThumbImg(goods.getHeadImg());
                        }
                        goodsSku.setSkuName("");
                        goodsSku.setSkuCode(sku.getSku_code());
                        goodsSku.setSkuAttrs(JSONObject.toJSONString(sku.getSku_attrs()));
                        goodsSku.setSalePrice(sku.getSale_price());
                        goodsSku.setStockNum(sku.getStock_num());
                        goodsSku.setStatus(sku.getStatus());
                        goodsSku.setSkuDeliverInfo(JSONObject.toJSONString(sku.getSku_deliver_info()));
                        skuList.add(goodsSku);
                    }
                    goods.setSkus(skuList);
                    var result = shopGoodsService.saveAndUpdateGoods(params.getShopId(), goods);
                    if (result.getCode() == 0) {
                        insert++;
                    } else if (result.getCode() == ResultVoEnum.DataExist.getIndex()) {
                        update++;
                    } else {
                        fail++;
                    }
                }
                ErpShopPullLogs logs = new ErpShopPullLogs();
                logs.setTenantId(getUserId());
                logs.setShopType(EnumShopType.WEI.getIndex());
                logs.setShopId(params.getShopId());
                logs.setPullType("GOODS");
                logs.setPullWay("主动拉取");
                logs.setPullParams("{status:5}");
                logs.setPullResult("{insert:" + insert + ",update:" + update + ",fail:" + fail + "}");
                logs.setPullTime(currDateTime);
                logs.setDuration(System.currentTimeMillis() - beginTime);
                pullLogsService.save(logs);
            }
        } else if (shop.getType()==3) {
            // 拼多多
            var checkResult = pddApiCommon.checkBefore(params.getShopId());
            if (checkResult.getCode() != ResultVoEnum.SUCCESS.getIndex()) {
//            return AjaxResult.error(checkResult.getCode(), checkResult.getMsg(), checkResult.getData());
                ErpShopPullLogs logs = new ErpShopPullLogs();
                logs.setTenantId(getUserId());
                logs.setShopType(EnumShopType.PDD.getIndex());
                logs.setShopId(params.getShopId());
                logs.setPullType("GOODS");
                logs.setPullWay("主动拉取");
                logs.setPullParams("{}");
                logs.setPullResult("{insert:0,update:0,fail:0}");
                logs.setPullTime(currDateTime);
                logs.setDuration(System.currentTimeMillis() - beginTime);
                pullLogsService.save(logs);
                return AjaxResult.error(1401,checkResult.getMsg());
            }
            String accessToken = checkResult.getData().getAccessToken();
//            String serverUrl = checkResult.getData().getServerUrl();
            String appKey = checkResult.getData().getAppKey();
            String appSecret = checkResult.getData().getAppSecret();

            ApiResultVo<GoodsResultVo> resultVo = PddGoodsApiHelper.pullGoodsList(appKey, appSecret, accessToken, 1, 20);
//            if(resultVo.getCode() == 10019) return AjaxResult.error(HttpStatus.UNAUTHORIZED,"Token已过期");
            if(resultVo.getCode() !=0 ){
                ErpShopPullLogs logs = new ErpShopPullLogs();
                logs.setTenantId(getUserId());
                logs.setShopType(EnumShopType.PDD.getIndex());
                logs.setShopId(params.getShopId());
                logs.setPullType("GOODS");
                logs.setPullWay("主动拉取");
                logs.setPullParams("{}");
                logs.setPullResult("{insert:0,update:0,fail:0}");
                logs.setPullTime(currDateTime);
                logs.setDuration(System.currentTimeMillis() - beginTime);
                pullLogsService.save(logs);
                return AjaxResult.error("接口拉取错误："+resultVo.getMsg());
            }
            for (var g : resultVo.getData().getGoodsList()) {
                total++;
                ShopGoods goods = new ShopGoods();
                goods.setTenantId(getUserId());
                goods.setShopId(params.getShopId());
                goods.setShopType(shop.getType());
                goods.setProductId(g.getGoodsId().toString());
                goods.setTitle(g.getGoodsName());
                goods.setSubTitle("");
                goods.setHeadImg(g.getThumbUrl());
                goods.setHeadImgs("");
                goods.setDescInfo("");
                goods.setAttrs("");
                goods.setStatus(g.getIsOnsale());
                goods.setEditStatus(0);
                goods.setMinPrice(0);

                goods.setProductType(1);
                goods.setEditTime(g.getCreatedAt()+"");
                String outerGoodsId="";
                List<ShopGoodsSku> skuList = new ArrayList<>();
                for (var sku : g.getSkuList()) {
                    ShopGoodsSku goodsSku = new ShopGoodsSku();
                    goodsSku.setTenantId(goods.getTenantId());
                    goodsSku.setShopId(goods.getShopId());
                    goodsSku.setShopType(shop.getType());
                    goodsSku.setSkuId(sku.getSkuId().toString());
                    goodsSku.setProductId(goods.getProductId());
                    goodsSku.setOutSkuId(sku.getOuterId());
                    goodsSku.setThumbImg(goods.getHeadImg());
                    goodsSku.setSkuCode(sku.getOuterId());
                    outerGoodsId = sku.getOuterGoodsId();
                    goodsSku.setSkuAttrs(sku.getSpec_details());
                    goodsSku.setSalePrice(0);
                    goodsSku.setSkuName(sku.getSpec());
                    goodsSku.setStockNum(sku.getSkuQuantity());
                    goodsSku.setStatus(goods.getStatus());
                    goodsSku.setSkuDeliverInfo("");
                    goodsSku.setQuantity(sku.getSkuQuantity());
                    skuList.add(goodsSku);
                }
                goods.setSpuCode(outerGoodsId);
                goods.setOutProductId(outerGoodsId);
                goods.setSkus(skuList);

                var result = shopGoodsService.saveAndUpdateGoods(params.getShopId(), goods);
                if (result.getCode() == 0) {
                    insert++;
                } else if (result.getCode() == ResultVoEnum.DataExist.getIndex()) {
                    update++;
                } else {
                    fail++;
                }
            }

        }else{
            // 未知平台，不支持
            return AjaxResult.error("未知平台，不支持");
        }

        Map<String, Object> data = new HashMap<>();
        data.put("insert", insert);
        data.put("update", update);
        data.put("fail", fail);
        data.put("total", total);
        return AjaxResult.success(data);

    }
}
