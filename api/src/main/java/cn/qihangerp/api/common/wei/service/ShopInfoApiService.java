package cn.qihangerp.api.common.wei.service;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.service.annotation.GetExchange;
import org.springframework.web.service.annotation.HttpExchange;
import cn.qihangerp.api.common.wei.vo.ShopApiResultVo;

@HttpExchange
public interface ShopInfoApiService {
    @GetExchange("/channels/ec/basics/info/get")
    ShopApiResultVo getShopInfo(@RequestParam String access_token);
}
