package cn.qihangerp.api.controller.shop;

import cn.qihangerp.api.common.AjaxResult;
import cn.qihangerp.api.domain.ErpLogisticsCompany;
import cn.qihangerp.api.domain.Shop;
import cn.qihangerp.api.service.ErpLogisticsCompanyService;
import cn.qihangerp.api.service.ShopService;
import cn.qihangerp.open.common.ApiResultVo;
import cn.qihangerp.open.pdd.PddLogisticsApiHelper;
import cn.qihangerp.open.wei.WeiLogisticsApiHelper;
import cn.qihangerp.open.wei.WeiTokenApiHelper;
import cn.qihangerp.open.wei.WeiTokenResponse;
import cn.qihangerp.open.wei.model.LogisticsCompany;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RequestMapping("/logistics")
@RestController
@AllArgsConstructor
public class LogisticsApiController {
    private final WeiApiCommon apiCommon;
    private final ShopService shopService;
    private final ErpLogisticsCompanyService logisticsCompanyService;

    @RequestMapping(value = "/pull_logistics_company", method = RequestMethod.POST)
    public AjaxResult pullLogisticsCompany(@RequestParam Integer platformId) {
        List<Shop> shops = shopService.selectShopByShopType(platformId);
        if (shops.isEmpty()) return AjaxResult.error("没有找到店铺信息");
        if (!StringUtils.hasText(shops.get(0).getAppKey())) {
            return AjaxResult.error("店铺参数配置错误，没有找到AppKey");
        }
        if (!StringUtils.hasText(shops.get(0).getAppSercet())) {
            return AjaxResult.error("店铺参数配置错误，没有找到AppSecret");
        }
        if (platformId == 5) {
            String accessToken = "";
            if (!StringUtils.hasText(shops.get(0).getAccessToken())) {
                ApiResultVo<WeiTokenResponse> token1 = WeiTokenApiHelper.getToken(shops.get(0).getAppKey(), shops.get(0).getAppSercet());
                if (token1.getCode() == 0) {
                    accessToken = token1.getData().getAccess_token();
                    shopService.updateSessionKey(Long.parseLong(shops.get(0).getId()), accessToken, "");
                } else {
                    return AjaxResult.error(token1.getMsg());
                }
            } else {
                accessToken = shops.get(0).getAccessToken();
                // 调用 店铺基本信息接口 验证Token
                ApiResultVo<WeiTokenResponse> tokenApiResultVo = WeiTokenApiHelper.checkToken(shops.get(0).getAppKey(), shops.get(0).getAppSercet(), accessToken);
                if (tokenApiResultVo.getCode() != 0) {
                    ApiResultVo<WeiTokenResponse> token2 = WeiTokenApiHelper.getToken(shops.get(0).getAppKey(), shops.get(0).getAppSercet());
                    if (token2.getCode() == 0) {
                        accessToken = token2.getData().getAccess_token();
                        shopService.updateSessionKey(Long.parseLong(shops.get(0).getId()), accessToken, "");
                    } else {
                        return AjaxResult.error(token2.getMsg());
                    }
                }
            }

            ApiResultVo<LogisticsCompany> apiResultVo = WeiLogisticsApiHelper.pullLogisticsCompanyList(accessToken);
            if (apiResultVo.getCode() == 0) {
                for (var item : apiResultVo.getList()) {
                    ErpLogisticsCompany lc = new ErpLogisticsCompany();
                    lc.setTenantId(shops.get(0).getTenantId());
                    lc.setPlatformId(shops.get(0).getType());
//                lc.setCode(item.getCode());
                    lc.setName(item.getDelivery_name());
                    lc.setLogisticsId(item.getDelivery_id());
                    logisticsCompanyService.insert(lc);
                    log.info("=====添加快递公司wei=====");
                }
            }
        } else if (platformId == 3) {
            try {
                ApiResultVo<List<cn.qihangerp.open.pdd.model.LogisticsCompany>> apiResultVo = PddLogisticsApiHelper.getLogisticsCompany(shops.get(0).getAppKey(), shops.get(0).getAppSercet());
                if (apiResultVo.getCode() == 0) {
                    for (var item : apiResultVo.getData()) {
                        ErpLogisticsCompany lc = new ErpLogisticsCompany();
                        lc.setTenantId(shops.get(0).getTenantId());
                        lc.setPlatformId(shops.get(0).getType());
                        lc.setCode(item.getCode());
                        lc.setName(item.getLogistics_company());
                        lc.setLogisticsId(item.getId().toString());
                        lc.setStatus(0);
                        logisticsCompanyService.insert(lc);
                        log.info("=====添加快递公司pdd=====");
                    }
                }
            } catch (Exception e) {
                return AjaxResult.error(e.getMessage());
            }
        }
        return AjaxResult.success();
    }


}
