package cn.qihangerp.api.controller.shop;

import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.common.enums.EnumShopType;
import cn.qihangerp.api.domain.ErpShopPullLogs;
import cn.qihangerp.api.domain.ShopGoods;
import cn.qihangerp.api.domain.ShopGoodsSku;
import cn.qihangerp.api.service.ErpShopPullLogsService;
import cn.qihangerp.api.service.ShopGoodsService;
import cn.qihangerp.open.common.ApiResultVo;
import cn.qihangerp.open.wei.WeiGoodsApiService;
import cn.qihangerp.open.wei.model.Product;
import com.alibaba.fastjson2.JSONObject;

import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
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
    private final ApiCommon apiCommon;
    private final ShopGoodsService shopGoodsService;
    private final WeiGoodsApiService goodsApiService;
    private final ErpShopPullLogsService pullLogsService;

    @RequestMapping(value = "/pull_list", method = RequestMethod.POST)
    public AjaxResult pullList(@RequestBody PullRequest params) throws Exception {
        if (params.getShopId() == null || params.getShopId() <= 0) {
//            return ApiResul new ApiResult(HttpStatus.PARAMS_ERROR, "参数错误，没有店铺Id");
            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，没有店铺Id");
        }
        Date currDateTime = new Date();
        long beginTime = System.currentTimeMillis();

        var checkResult = apiCommon.checkBefore(params.getShopId());
        if (checkResult.getCode() != ResultVoEnum.SUCCESS.getIndex()) {
//            return AjaxResult.error(checkResult.getCode(), checkResult.getMsg(), checkResult.getData());
            return AjaxResult.error(checkResult.getMsg());
        }
        String accessToken = checkResult.getData().getAccessToken();
        String serverUrl = checkResult.getData().getServerUrl();
        String appKey = checkResult.getData().getAppKey();
        String appSecret = checkResult.getData().getAppSecret();
        int total=0;
        int insert=0;
        int update=0;
        int fail=0;
        ApiResultVo<Product> productApiResultVo = goodsApiService.pullGoodsList(accessToken);
        if(productApiResultVo.getCode() == 0){
            // 成功
            for (var product:productApiResultVo.getList()){
                total++;
                ShopGoods goods = new ShopGoods();
                goods.setTenantId(getUserId());
                goods.setShopId(params.getShopId());
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
                List<ShopGoodsSku> skuList = new ArrayList<>();
                for (var sku:product.getSkus()) {
                    ShopGoodsSku goodsSku = new ShopGoodsSku();
                    goodsSku.setTenantId(goods.getTenantId());
                    goodsSku.setShopId(goods.getShopId());
                    goodsSku.setSkuId(sku.getSku_id());
                    goodsSku.setProductId(product.getProduct_id());
                    goodsSku.setOutSkuId(sku.getOut_sku_id());
                    goodsSku.setThumbImg(sku.getThumb_img());
                    if(StringUtils.isBlank(goodsSku.getThumbImg())){
                        goodsSku.setThumbImg(goods.getHeadImg());
                    }
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
                if(result.getCode() == 0){
                    insert++;
                } else if (result.getCode()==ResultVoEnum.DataExist.getIndex()) {
                    update++;
                }else{
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
        }else {
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

            return AjaxResult.error(productApiResultVo.getMsg());
        }

        Map<String, Object> data = new HashMap<>();
        data.put("insert", insert);
        data.put("update", update);
        data.put("fail", fail);
        data.put("total", total);
        return AjaxResult.success(data);

    }
}
