package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.domain.ShopGoods;
import cn.qihangerp.api.domain.ShopGoodsSku;
import cn.qihangerp.api.request.LinkErpGoodsSkuBo;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【erp_shop_goods_sku】的数据库操作Service
* @createDate 2024-04-21 18:52:54
*/
public interface ShopGoodsSkuService extends IService<ShopGoodsSku> {
    PageResult<ShopGoodsSku> queryPageList(ShopGoodsSku bo, PageQuery pageQuery);
    ResultVo linkErpGoodsSku(LinkErpGoodsSkuBo bo);
}
