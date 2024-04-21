package cn.qihangerp.api.common.wei;


import cn.qihangerp.api.service.ShopService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.common.enums.EnumShopType;
import cn.qihangerp.api.common.enums.HttpStatus;
import cn.qihangerp.api.common.wei.service.ShopInfoApiService;
import cn.qihangerp.api.common.wei.service.TokenApiService;
import cn.qihangerp.api.common.wei.vo.ShopApiResultVo;
import cn.qihangerp.api.common.wei.vo.Token;
import cn.qihangerp.api.service.SysPlatformService;


@AllArgsConstructor
@Component
public class ApiCommon {
    private final ShopService shopService;
    private final SysPlatformService platformService;
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
            return ResultVo.error(HttpStatus.PARAMS_ERROR,"参数错误，没有找到店铺");
        }
        if (shop.getType() != EnumShopType.WEI.getIndex()) {
            return ResultVo.error(HttpStatus.PARAMS_ERROR, "参数错误，店铺不是JD店铺");
        }
        if(!StringUtils.hasText(shop.getAppKey())) {
            return ResultVo.error(HttpStatus.PARAMS_ERROR, "平台配置错误，没有找到AppKey");
        }
        if(!StringUtils.hasText(shop.getAppSercet())) {
            return ResultVo.error(HttpStatus.PARAMS_ERROR, "第三方平台配置错误，没有找到AppSercet");
        }
        var platform =platformService.getById(EnumShopType.WEI.getIndex());
        if(!StringUtils.hasText(platform.getServerUrl())) {
            return ResultVo.error(HttpStatus.PARAMS_ERROR, "第三方平台配置错误，没有找到ServerUrl");
        }

        ShopApiParams params = new ShopApiParams();
        params.setAppKey(shop.getAppKey());
        params.setAppSecret(shop.getAppSercet());
        params.setAccessToken(shop.getAccessToken());
        params.setApiRequestUrl(shop.getApiRequestUrl());
        params.setServerUrl(platform.getServerUrl());
        params.setSellerId(shop.getSellerId().toString());
        if (!StringUtils.hasText(shop.getAccessToken())) {
//            String s = "/token?grant_type=client_credential&appid="+params.getAppKey()+"&secret="+params.getAppSecret();
            TokenApiService remoting = RemoteUtil.Remoting(params.getServerUrl(), TokenApiService.class);
            Token token = remoting.getToken("client_credential",params.getAppKey(),params.getAppSecret());
            if(token.getErrcode()==null) {
                params.setAccessToken(token.getAccess_token());
                shopService.updateSessionKey(shopId, token.getAccess_token());
            }else{
                return ResultVo.error(HttpStatus.PARAMS_ERROR, token.getErrmsg());
            }
        }else {
            // 调用 店铺基本信息接口 验证Token
            ShopInfoApiService remoting = RemoteUtil.Remoting(params.getServerUrl(), ShopInfoApiService.class);
            ShopApiResultVo shopInfo = remoting.getShopInfo(params.getAccessToken());
            if(shopInfo.getErrcode() == 42001){
                // Token过期
                TokenApiService remoting1 = RemoteUtil.Remoting(params.getServerUrl(), TokenApiService.class);
                Token token = remoting1.getToken("client_credential",params.getAppKey(),params.getAppSecret());
                if(token.getErrcode()==null) {
                    params.setAccessToken(token.getAccess_token());
                    shopService.updateSessionKey(shopId, token.getAccess_token());
                }else{
                    return ResultVo.error(HttpStatus.PARAMS_ERROR, token.getErrmsg());
                }
            }
        }
        return ResultVo.success(params);
    }

}
