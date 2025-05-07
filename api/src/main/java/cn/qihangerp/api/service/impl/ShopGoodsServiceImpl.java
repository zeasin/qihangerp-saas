package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.common.ResultVoEnum;
import cn.qihangerp.api.common.utils.StringUtils;
import cn.qihangerp.api.domain.*;
import cn.qihangerp.api.mapper.ErpGoodsMapper;
import cn.qihangerp.api.mapper.ErpGoodsSkuMapper;
import cn.qihangerp.api.mapper.ShopGoodsSkuMapper;
import cn.qihangerp.api.service.ShopService;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.service.ShopGoodsService;
import cn.qihangerp.api.mapper.ShopGoodsMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
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
    private final ErpGoodsMapper goodsMapper;
    private final ShopService shopService;

    @Override
    public PageResult<ShopGoods> queryPageList(ShopGoods bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ShopGoods> queryWrapper = new LambdaQueryWrapper<ShopGoods>()
                .eq(bo.getShopId()!=null,ShopGoods::getShopId,bo.getShopId())
                .eq(bo.getTenantId()!=null,ShopGoods::getTenantId,bo.getTenantId());

        Page<ShopGoods> pages = mapper.selectPage(pageQuery.build(), queryWrapper);
        if(pages.getTotal()>0){
            for(ShopGoods goods : pages.getRecords()){
                goods.setSkus(skuMapper.selectList(new LambdaQueryWrapper<ShopGoodsSku>().eq(ShopGoodsSku::getShopGoodsId,goods.getId())));
            }
        }

        return PageResult.build(pages);
    }

    @Override
    public ResultVo saveAndUpdateGoods(Long shopId, ShopGoods goods) {
        Shop shop = shopService.getById(shopId);
        if(shop==null) return ResultVo.error("店铺不存在");
        List<ShopGoods> goodsList = mapper.selectList(
                new LambdaQueryWrapper<ShopGoods>()
                .eq(ShopGoods::getProductId, goods.getProductId())
        );

        if (goodsList != null && goodsList.size() > 0) {
            // 更新
            // 存在，更新
            goods.setShopId(shopId);
            goods.setTenantId(shop.getTenantId());
            goods.setId(goodsList.get(0).getId());
            mapper.updateById(goods);

            // 删除sku
            skuMapper.delete(new LambdaQueryWrapper<ShopGoodsSku>().eq(ShopGoodsSku::getShopGoodsId,goods.getId()));
            // 重新插入sku
            if(goods.getSkus()!=null) {
                for (var sku : goods.getSkus()) {
                    sku.setShopGoodsId(Long.parseLong(goods.getId()));
                    sku.setShopId(goods.getShopId());
                    sku.setTenantId(goods.getTenantId());
                    // 根据OuterId查找ERP系统中的skuid
                    if(StringUtils.isNotEmpty(sku.getSkuCode())) {
                        List<ErpGoodsSku> erpGoodsSkus = goodsSkuMapper.selectList(
                                new LambdaQueryWrapper<ErpGoodsSku>()
                                .eq(ErpGoodsSku::getSpecNum, sku.getSkuCode()));

                        if(erpGoodsSkus!=null && !erpGoodsSkus.isEmpty()){
                            sku.setErpGoodsId(Long.parseLong(erpGoodsSkus.get(0).getGoodsId()));
                            sku.setErpGoodsSkuId(Long.parseLong(erpGoodsSkus.get(0).getId()));
                        }
                    }
                    skuMapper.insert(sku);
                }
            }

            return ResultVo.error(ResultVoEnum.DataExist.getIndex(),"更新成功");
        } else {
            // 不存在，新增return 0;
            // 不存在，新增
            goods.setShopId(shopId);
            goods.setTenantId(shop.getTenantId());
            mapper.insert(goods);
            // 插入sku
            if(goods.getSkus()!=null) {
                for (var sku : goods.getSkus()) {
                    sku.setShopGoodsId(Long.parseLong(goods.getId()));
                    sku.setShopId(goods.getShopId());
                    sku.setTenantId(goods.getTenantId());
                    // 根据OuterId查找ERP系统中的skuid
                    if(StringUtils.isNotEmpty(sku.getSkuCode())) {
                        List<ErpGoodsSku> erpGoodsSkus = goodsSkuMapper.selectList(new LambdaQueryWrapper<ErpGoodsSku>().eq(ErpGoodsSku::getSpecNum, sku.getSkuCode()));
                        if(erpGoodsSkus!=null && !erpGoodsSkus.isEmpty()){
                            sku.setErpGoodsId(Long.parseLong(erpGoodsSkus.get(0).getGoodsId()));
                            sku.setErpGoodsSkuId(Long.parseLong(erpGoodsSkus.get(0).getId()));
                        }
                    }
                    skuMapper.insert(sku);
                }
            }
            return ResultVo.success();
        }
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public ResultVo pushToErp(Long shopGoodsId) {
        ShopGoods shopGoods = mapper.selectById(shopGoodsId);
        if(shopGoods==null) return ResultVo.error("店铺商品数据不存在");
        List<ShopGoodsSku> shopGoodsSkus = skuMapper.selectList(new LambdaQueryWrapper<ShopGoodsSku>().eq(ShopGoodsSku::getShopGoodsId, shopGoodsId));
        if(shopGoodsSkus==null || shopGoodsSkus.isEmpty()) return ResultVo.error("店铺商品Sku数据不存在");
        String goodsNum ="";
        if(org.springframework.util.StringUtils.hasText(shopGoods.getOutProductId())){
            goodsNum = shopGoods.getOutProductId();
        }else {
            goodsNum = shopGoods.getProductId();
        }

        // 用商家编码查询
        List<ErpGoods> erpGoodsList = goodsMapper.selectList(new LambdaQueryWrapper<ErpGoods>()
                .eq(ErpGoods::getNumber, goodsNum));
        if(erpGoodsList!=null && !erpGoodsList.isEmpty()){
            return ResultVo.error(ResultVoEnum.DataExist.getIndex(),"商家编码已存在");
        }

        // 添加商品
        ErpGoods erpGoods = new ErpGoods();
        erpGoods.setTenantId(shopGoods.getTenantId());
        erpGoods.setName(shopGoods.getTitle());
        erpGoods.setImage(shopGoods.getHeadImg());
        erpGoods.setNumber(goodsNum);
        erpGoods.setRemark("店铺商品同步");
        erpGoods.setStatus(1);
        erpGoods.setDisable(1);
        if (shopGoods.getMinPrice() != null) {
            erpGoods.setRetailPrice(BigDecimal.valueOf(shopGoods.getMinPrice()/100));
        }
        erpGoods.setCreateBy("店铺商品同步");
        erpGoods.setCreateTime(new Date());
        goodsMapper.insert(erpGoods);

        //更新shopGoods
        ShopGoods shopGoodsUpdate = new ShopGoods();
        shopGoodsUpdate.setId(shopGoods.getId());
        shopGoodsUpdate.setErpGoodsId(Long.parseLong(erpGoods.getId()));
        mapper.updateById(shopGoodsUpdate);

        // 添加商品SKU
        for (var sku:shopGoodsSkus){
            ErpGoodsSku erpGoodsSku = new ErpGoodsSku();
            erpGoodsSku.setGoodsId(erpGoods.getId());
            erpGoodsSku.setTenantId(erpGoods.getTenantId());
            erpGoodsSku.setGoodsName(erpGoods.getName());
            erpGoodsSku.setGoodsNum(erpGoods.getNumber());
            erpGoodsSku.setSpecNum(sku.getSkuCode());
            if(org.springframework.util.StringUtils.hasText(sku.getThumbImg())) {
                erpGoodsSku.setColorImage(sku.getThumbImg());
            }else {
                erpGoodsSku.setColorImage(erpGoods.getImage());
            }
            // sku属性拆解
            if(StringUtils.isNotEmpty(sku.getSkuAttrs())){
                try{
                    JSONArray jsonArray = JSONArray.parse(sku.getSkuAttrs());
                    if(jsonArray!=null && !jsonArray.isEmpty()){
                        if(jsonArray.size()>0){
                            JSONObject jsonObject = jsonArray.getJSONObject(0);
                            erpGoodsSku.setColorId(0L);
                            erpGoodsSku.setColorLabel(jsonObject.getString("attr_key"));
                            erpGoodsSku.setColorValue(jsonObject.getString("attr_value"));
                        }
                        if(jsonArray.size()>1){
                            JSONObject jsonObject = jsonArray.getJSONObject(1);
                            erpGoodsSku.setSizeId(0L);
                            erpGoodsSku.setSizeLabel(jsonObject.getString("attr_key"));
                            erpGoodsSku.setSizeValue(jsonObject.getString("attr_value"));
                        }
                        if(jsonArray.size()>2){
                            JSONObject jsonObject = jsonArray.getJSONObject(2);
                            erpGoodsSku.setStyleId(0L);
                            erpGoodsSku.setStyleLabel(jsonObject.getString("attr_key"));
                            erpGoodsSku.setStyleValue(jsonObject.getString("attr_value"));
                        }
                    }
                }catch (Exception e){

                }
            }
            String spec="默认";
            if(StringUtils.isNotEmpty(erpGoodsSku.getColorValue())){
                spec = erpGoodsSku.getColorValue();
            }
            if(StringUtils.isNotEmpty(erpGoodsSku.getSizeValue())){
                spec += " "+erpGoodsSku.getSizeValue();
            }
            if(StringUtils.isNotEmpty(erpGoodsSku.getStyleValue())){
                spec += " "+erpGoodsSku.getStyleValue();
            }
            erpGoodsSku.setSpecName(spec);
            if(sku.getSalePrice()!=null){
                erpGoodsSku.setRetailPrice(BigDecimal.valueOf(sku.getSalePrice()/100));
            }
            erpGoodsSku.setStatus(1);
            goodsSkuMapper.insert(erpGoodsSku);

            //更新ShopGoodsSku
            ShopGoodsSku shopGoodsSkuUpdate = new ShopGoodsSku();
            shopGoodsSkuUpdate.setId(sku.getId());
            shopGoodsSkuUpdate.setErpGoodsId(Long.parseLong(erpGoods.getId()));
            shopGoodsSkuUpdate.setErpGoodsSkuId(Long.parseLong(erpGoodsSku.getId()));
            skuMapper.updateById(shopGoodsSkuUpdate);
        }

        return ResultVo.success();
    }
}




