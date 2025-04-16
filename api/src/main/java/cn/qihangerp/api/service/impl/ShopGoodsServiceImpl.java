package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVoEnum;
import cn.qihangerp.api.common.utils.StringUtils;
import cn.qihangerp.api.domain.*;
import cn.qihangerp.api.mapper.ErpGoodsSkuMapper;
import cn.qihangerp.api.mapper.ShopGoodsSkuMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.service.ShopGoodsService;
import cn.qihangerp.api.mapper.ShopGoodsMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author qilip
* @description 针对表【erp_shop_goods】的数据库操作Service实现
* @createDate 2024-04-21 18:52:54
*/
@AllArgsConstructor
@Service
public class ShopGoodsServiceImpl extends ServiceImpl<ShopGoodsMapper, ShopGoods>
    implements ShopGoodsService{
    private final ShopGoodsMapper mapper;
    private final ShopGoodsSkuMapper skuMapper;
    private final ErpGoodsSkuMapper goodsSkuMapper;

    @Override
    public PageResult<ShopGoods> queryPageList(ShopGoods bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ShopGoods> queryWrapper = new LambdaQueryWrapper<ShopGoods>()
                .eq(bo.getShopId()!=null,ShopGoods::getShopId,bo.getShopId())
                .eq(ShopGoods::getTenantId,bo.getTenantId());

        Page<ShopGoods> pages = mapper.selectPage(pageQuery.build(), queryWrapper);
        if(pages.getTotal()>0){
            for(ShopGoods goods : pages.getRecords()){
                goods.setSkus(skuMapper.selectList(new LambdaQueryWrapper<ShopGoodsSku>().eq(ShopGoodsSku::getShopGoodsId,goods.getId())));
            }
        }

        return PageResult.build(pages);
    }

    @Override
    public int saveAndUpdateGoods(Long shopId, ShopGoods goods) {
        List<ShopGoods> goodsList = mapper.selectList(
                new LambdaQueryWrapper<ShopGoods>()
                .eq(ShopGoods::getProductId, goods.getProductId())
        );

        if (goodsList != null && goodsList.size() > 0) {
            // 更新
            // 存在，更新
            goods.setShopId(shopId);
            goods.setId(goodsList.get(0).getId());
            mapper.updateById(goods);

            // 删除sku
            skuMapper.delete(new LambdaQueryWrapper<ShopGoodsSku>().eq(ShopGoodsSku::getShopGoodsId,goods.getId()));
            // 重新插入sku
            if(goods.getSkus()!=null) {
                for (var sku : goods.getSkus()) {
                    sku.setShopGoodsId(Long.parseLong(goods.getId()));
                    // 根据OuterId查找ERP系统中的skuid
                    if(StringUtils.isNotEmpty(sku.getSkuCode())) {
                        List<ErpGoodsSku> erpGoodsSkus = goodsSkuMapper.selectList(new LambdaQueryWrapper<ErpGoodsSku>().eq(ErpGoodsSku::getSpecNum, sku.getSkuCode()));
                        if(erpGoodsSkus!=null && !erpGoodsSkus.isEmpty()){
                            sku.setErpGoodsId(Long.parseLong(erpGoodsSkus.get(0).getGoodsId()));
                            sku.setErpGoodsSkuId(erpGoodsSkus.get(0).getId());
                        }
                    }
                    skuMapper.insert(sku);
                }
            }

            return ResultVoEnum.DataExist.getIndex();
        } else {
            // 不存在，新增return 0;
            // 不存在，新增
            goods.setShopId(shopId);
            mapper.insert(goods);
            // 插入sku
            if(goods.getSkus()!=null) {
                for (var sku : goods.getSkus()) {
                    sku.setShopGoodsId(Long.parseLong(goods.getId()));
                    // 根据OuterId查找ERP系统中的skuid
                    if(StringUtils.isNotEmpty(sku.getSkuCode())) {
                        List<ErpGoodsSku> erpGoodsSkus = goodsSkuMapper.selectList(new LambdaQueryWrapper<ErpGoodsSku>().eq(ErpGoodsSku::getSpecNum, sku.getSkuCode()));
                        if(erpGoodsSkus!=null && !erpGoodsSkus.isEmpty()){
                            sku.setErpGoodsId(Long.parseLong(erpGoodsSkus.get(0).getGoodsId()));
                            sku.setErpGoodsSkuId(erpGoodsSkus.get(0).getId());
                        }
                    }
                    skuMapper.insert(sku);
                }
            }
            return 0;
        }
    }
}




