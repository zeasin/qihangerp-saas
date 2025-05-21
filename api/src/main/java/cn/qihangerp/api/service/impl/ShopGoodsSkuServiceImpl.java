package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ShopGoods;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ShopGoodsSku;
import cn.qihangerp.api.service.ShopGoodsSkuService;
import cn.qihangerp.api.mapper.ShopGoodsSkuMapper;
import org.springframework.stereotype.Service;

/**
* @author qilip
* @description 针对表【erp_shop_goods_sku】的数据库操作Service实现
* @createDate 2024-04-21 18:52:54
*/
@Service
public class ShopGoodsSkuServiceImpl extends ServiceImpl<ShopGoodsSkuMapper, ShopGoodsSku>
    implements ShopGoodsSkuService{

    @Override
    public PageResult<ShopGoodsSku> queryPageList(ShopGoodsSku bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ShopGoodsSku> queryWrapper = new LambdaQueryWrapper<ShopGoodsSku>()
                .eq(bo.getShopId()!=null,ShopGoodsSku::getShopId,bo.getShopId())
                .eq(ShopGoodsSku::getShopType,bo.getShopType())
                .eq(bo.getTenantId()!=null,ShopGoodsSku::getTenantId,bo.getTenantId());

        Page<ShopGoodsSku> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);


        return PageResult.build(pages);
    }
}




