package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.domain.ErpGoods;
import cn.qihangerp.api.domain.ErpGoodsSku;
import cn.qihangerp.api.domain.ShopGoods;
import cn.qihangerp.api.mapper.ErpGoodsMapper;
import cn.qihangerp.api.mapper.ErpGoodsSkuMapper;
import cn.qihangerp.api.mapper.ShopGoodsMapper;
import cn.qihangerp.api.request.LinkErpGoodsSkuBo;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ShopGoodsSku;
import cn.qihangerp.api.service.ShopGoodsSkuService;
import cn.qihangerp.api.mapper.ShopGoodsSkuMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
* @author qilip
* @description 针对表【erp_shop_goods_sku】的数据库操作Service实现
* @createDate 2024-04-21 18:52:54
*/
@AllArgsConstructor
@Service
public class ShopGoodsSkuServiceImpl extends ServiceImpl<ShopGoodsSkuMapper, ShopGoodsSku>
    implements ShopGoodsSkuService{
    private final ErpGoodsSkuMapper erpGoodsSkuMapper;
    private final ErpGoodsMapper erpGoodsMapper;
    private final ShopGoodsMapper shopGoodsMapper;

    @Override
    public PageResult<ShopGoodsSku> queryPageList(ShopGoodsSku bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ShopGoodsSku> queryWrapper = new LambdaQueryWrapper<ShopGoodsSku>()
                .eq(bo.getShopId()!=null,ShopGoodsSku::getShopId,bo.getShopId())
                .eq(ShopGoodsSku::getShopType,bo.getShopType())
                .eq(bo.getTenantId()!=null,ShopGoodsSku::getTenantId,bo.getTenantId());

        Page<ShopGoodsSku> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);


        return PageResult.build(pages);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public ResultVo linkErpGoodsSku(LinkErpGoodsSkuBo bo) {
        ErpGoodsSku oGoodsSku = erpGoodsSkuMapper.selectById(bo.getErpGoodsSkuId());
        if(oGoodsSku == null) return ResultVo.error("未找到系统商品sku");

        ErpGoods oGoods=erpGoodsMapper.selectById(oGoodsSku.getGoodsId());
        if(oGoods == null){
            return ResultVo.error("未找到系统商品");
        }

        ShopGoodsSku shopGoodsSku = this.baseMapper.selectById(bo.getId());
        if(shopGoodsSku == null) {
            return ResultVo.error("店铺商品sku数据不存在");
        }
        List<ShopGoods> shopGoods = shopGoodsMapper.selectList(
                new LambdaQueryWrapper<ShopGoods>().eq(ShopGoods::getProductId, shopGoodsSku.getProductId()));
        if(shopGoods==null||shopGoods.size()==0){
            return ResultVo.error("店铺商品数据不存在");
        }

        ShopGoodsSku sku = new ShopGoodsSku();
        sku.setId(bo.getId().toString());
        sku.setErpGoodsId(oGoodsSku.getGoodsId());
        sku.setErpGoodsSkuId(oGoodsSku.getId());
        this.baseMapper.updateById(sku);

        ShopGoods goodsUp=new ShopGoods();
        goodsUp.setId(shopGoods.get(0).getId());
        goodsUp.setErpGoodsId(oGoodsSku.getGoodsId());
        shopGoodsMapper.updateById(goodsUp);
        return ResultVo.success();
    }
}




