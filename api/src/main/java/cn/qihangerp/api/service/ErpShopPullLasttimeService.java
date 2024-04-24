package cn.qihangerp.api.service;

import cn.qihangerp.api.domain.ErpShopPullLasttime;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【erp_shop_pull_lasttime(店铺更新最后时间记录)】的数据库操作Service
* @createDate 2024-04-24 22:01:37
*/
public interface ErpShopPullLasttimeService extends IService<ErpShopPullLasttime> {
    ErpShopPullLasttime getLasttimeByShop(Long tenanId,Long shopId, String pullType);
}
