package cn.qihangerp.api.service;

import cn.qihangerp.api.domain.Shop;
import cn.qihangerp.api.domain.SysPlatform;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author qilip
* @description 针对表【erp_shop(数据中心-店铺)】的数据库操作Service
* @createDate 2024-04-21 18:20:49
*/
public interface ShopService extends IService<Shop> {
    List<Shop> selectShopList(Shop shop);
    void updateSessionKey(Long shopId,String sessionKey);
}
