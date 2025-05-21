package cn.qihangerp.api.controller.shop;

import cn.qihangerp.api.common.AjaxResult;
import cn.qihangerp.api.domain.Shop;
import cn.qihangerp.api.service.ShopService;
import cn.qihangerp.open.common.ApiResultVo;
import cn.qihangerp.open.pdd.PddTokenApiHelper;
import cn.qihangerp.open.pdd.model.Token;
import lombok.AllArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.net.URLEncoder;

@AllArgsConstructor
@RequestMapping("/oauth/pdd")
@RestController
public class PddOAuthController {
    private final ShopService shopService;


    private static Logger log = LoggerFactory.getLogger(PddOAuthController.class);

    @GetMapping("/getOauthUrl")
    public AjaxResult oauth(@RequestParam Integer shopId) {
        Shop shop = shopService.getById(shopId);
        if(shop==null) return AjaxResult.error("店铺不存在");
        else if(shop.getType()!=3) return AjaxResult.error("非PDD店铺");
        if(StringUtils.isEmpty(shop.getApiCallbackUrl())) return AjaxResult.error("请设置回调URL");

        String url = "https://mms.pinduoduo.com/open.html?response_type=code&client_id=" + shop.getAppKey() + "&redirect_uri=" + URLEncoder.encode(shop.getApiCallbackUrl());
        return AjaxResult.success("SUCCESS",url);
    }

    @PostMapping("/getToken")
    public AjaxResult getToken(@RequestBody PddTokenCreateBo bo) throws IOException, InterruptedException {
        log.info("/**********获取拼多多授权token*********/");
        var shop = shopService.getById(bo.getShopId());
        if(shop==null) return AjaxResult.error("店铺不存在");
        else if(shop.getType()!=3) return AjaxResult.error("非PDD店铺");

        ApiResultVo<Token> token = PddTokenApiHelper.getToken(shop.getAppKey(), shop.getAppSercet(), bo.getCode());
        if(token.getCode()==0){
            shopService.updateSessionKey(Long.parseLong(shop.getId()),token.getData().getAccess_token(),token.getData().getRefresh_token());
            return AjaxResult.success("SUCCESS");
        }else
            return AjaxResult.error(token.getMsg());
    }

//    /**
//     * 获取授权成功
//     * @param req
//     * @param model
//     * @return
//     */
//    @RequestMapping("/getTokenSuccess")
//    public String getTokeSuccess(HttpServletRequest req, @RequestParam Long mallId, Model model){
//        var shop = shopService.selectShopById(mallId);
//        model.addAttribute("shop",shop);
//        model.addAttribute("shopId",shop.getId());
//        return "get_token_success";
//    }



}
