package cn.qihangerp.api.controller.shop;

import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.common.enums.EnumShopType;
import cn.qihangerp.api.common.enums.HttpStatus;
import cn.qihangerp.api.service.ShopService;
import cn.qihangerp.open.common.ShopApiParams;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

@AllArgsConstructor
@Component
public class PddApiCommon {
    private final ShopService shopService;

    /**
     * 更新前的检查
     *
     * @param shopId
     * @return
     * @throws
     */
    public ResultVo<ShopApiParams> checkBefore(Long shopId) {
        var shop = shopService.getById(shopId);
        if (shop == null) {
//            return new ApiResult<>(EnumResultVo.ParamsError.getIndex(), "参数错误，没有找到店铺");
            return ResultVo.error(HttpStatus.PARAMS_ERROR, "参数错误，没有找到店铺");
        }

        if (shop.getType() != EnumShopType.PDD.getIndex()) {
            return ResultVo.error(HttpStatus.PARAMS_ERROR, "参数错误，店铺不是pdd店铺");
        }

//        if (shop.getSellerId() == null || shop.getSellerId()<=0) {
//            return ResultVo.error(HttpStatus.PARAMS_ERROR, "参数错误，请设置抖店平台店铺ID（shopId）");
//        }

//        OShopPlatform platform = platformService.getById(EnumShopType.PDD.getIndex());

        if (!StringUtils.hasText(shop.getAppKey())) {
            return ResultVo.error(HttpStatus.PARAMS_ERROR, "店铺参数配置错误，没有找到AppKey");
        }
        if (!StringUtils.hasText(shop.getAppSercet())) {
            return ResultVo.error(HttpStatus.PARAMS_ERROR, "店铺参数配置错误，没有找到AppSercet");
        }
//        if (!StringUtils.hasText(platform.getRedirectUri())) {
//            return ResultVo.error(HttpStatus.PARAMS_ERROR, "第三方平台配置错误，没有找到RedirectUri");
//        }
//        if (!StringUtils.hasText(platform.getServerUrl())) {
//            return ResultVo.error(HttpStatus.PARAMS_ERROR, "第三方平台配置错误，没有找到ServerUrl");
//        }

//        if(shop.getSellerId() == null || shop.getSellerId() <= 0) {
//            return cn.qihangerp.tao.common.ApiResult.build(HttpStatus.PARAMS_ERROR,  "第三方平台配置错误，没有找到SellerUserId");
//        }

        ShopApiParams params = new ShopApiParams();
        params.setAppKey(shop.getAppKey());
        params.setAppSecret(shop.getAppSercet());
        params.setAccessToken(shop.getAccessToken());
        params.setApiRequestUrl(shop.getApiRequestUrl());
        params.setApiCallbackUrl(shop.getApiCallbackUrl());
        params.setSellerId(shop.getSellerId().toString());

        if (!StringUtils.hasText(shop.getAccessToken())) {
            return ResultVo.error(HttpStatus.UNAUTHORIZED, "Token已过期，请重新授权", params);
        }

        return ResultVo.success(params);
    }

}
