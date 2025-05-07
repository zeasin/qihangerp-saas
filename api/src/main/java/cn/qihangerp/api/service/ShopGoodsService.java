package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.domain.ShopGoods;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【erp_shop_goods】的数据库操作Service
* @createDate 2024-04-21 18:52:54
*/
public interface ShopGoodsService extends IService<ShopGoods> {
    PageResult<ShopGoods> queryPageList(ShopGoods bo, PageQuery pageQuery);
    ResultVo saveAndUpdateGoods(Long shopId,ShopGoods goods);
    ResultVo pushToErp(Long shopGoodsId);
}
