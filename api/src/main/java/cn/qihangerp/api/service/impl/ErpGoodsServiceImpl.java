package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.domain.*;
import cn.qihangerp.api.mapper.*;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.StringUtils;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.bo.GoodsSpecAddBo;
import cn.qihangerp.api.service.ErpGoodsService;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
* @author TW
* @description 针对表【erp_goods(商品库存管理)】的数据库操作Service实现
* @createDate 2024-04-12 14:52:05
*/
@AllArgsConstructor
@Service
public class ErpGoodsServiceImpl extends ServiceImpl<ErpGoodsMapper, ErpGoods>
    implements ErpGoodsService{
    private final ErpGoodsMapper mapper;
    private final ErpGoodsSkuMapper skuMapper;
    private final ErpGoodsSkuAttrMapper skuAttrMapper;
    private final ErpGoodsCategoryAttributeValueMapper attributeValueMapper;
    private final ErpGoodsCategoryAttributeMapper attributeMapper;
    @Override
    public PageResult<ErpGoods> queryPageList(ErpGoods bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpGoods> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ErpGoods::getTenantId,bo.getTenantId());
//        queryWrapper.eq(bo.getErpGoodsId()!=null,OGoodsSku::getErpGoodsId,bo.getErpGoodsId());
//        queryWrapper.eq(StringUtils.hasText(bo.getSkuNum()),OGoodsSku::getSkuNum,bo.getSkuNum());
        Page<ErpGoods> pages = mapper.selectPage(pageQuery.build(), queryWrapper);

        return PageResult.build(pages);
    }

    @Override
    public PageResult<ErpGoodsSku> querySkuPageList(ErpGoodsSku bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpGoodsSku> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ErpGoodsSku::getTenantId,bo.getTenantId());
//        queryWrapper.eq(bo.getErpGoodsId()!=null,OGoodsSku::getErpGoodsId,bo.getErpGoodsId());
//        queryWrapper.eq(StringUtils.hasText(bo.getSkuNum()),OGoodsSku::getSkuNum,bo.getSkuNum());
        Page<ErpGoodsSku> pages = skuMapper.selectPage(pageQuery.build(), queryWrapper);

        return PageResult.build(pages);
    }

    @Transactional
    @Override
    public int insertGoods(ErpGoods goods)
    {
        if(goods.getTenantId()==null)return -200;
        // 查询编码是否存在

//        ErpGoods goods1 = mapper.selectGoodsByNumber(goods.getNumber());
        ErpGoods goods1 = mapper.selectOne(new LambdaQueryWrapper<ErpGoods>().eq(ErpGoods::getNumber,goods.getNumber()));
        if(goods1!=null) return -1;

        // 1、添加主表erp_goods
        goods.setCreateTime(new Date());
        mapper.insert(goods);

        // 2、添加规格表erp_goods_spec
        for (GoodsSpecAddBo bo:goods.getSpecList()) {
            ErpGoodsSku spec = new ErpGoodsSku();
            spec.setTenantId(goods.getTenantId());
            spec.setGoodsId(goods.getId());
            spec.setSpecNum(bo.getSpecNum());
            spec.setColorId(bo.getColorId());
            spec.setColorValue(bo.getColorValue());
            if(goods.getColorImages()!=null && StringUtils.hasText(goods.getColorImages().get(bo.getColorId()))){
                spec.setColorImage(goods.getColorImages().get(bo.getColorId()));
            }else {
                spec.setColorImage(goods.getImage());
            }
            spec.setSizeId(bo.getSizeId());
            spec.setSizeValue(bo.getSizeValue());
            spec.setStyleId(bo.getStyleId());
            spec.setStyleValue(bo.getStyleValue());
            if(bo.getPurPrice() == null){
                spec.setPurPrice(goods.getPurPrice());
            }else spec.setPurPrice(bo.getPurPrice());
            spec.setStatus(1);
            spec.setDisable(0);
            skuMapper.insert(spec);
        }

        // 3、添加规格属性表erp_goods_spec_attr
        if(goods.getColorValues()!=null) {
            for (Long val:goods.getColorValues()) {
                ErpGoodsCategoryAttributeValue value = attributeValueMapper.selectById(val);
                if(value!=null) {
                    ErpGoodsCategoryAttribute attr = attributeMapper.selectById(value.getCategoryAttributeId());
                    ErpGoodsSkuAttr specAttr = new ErpGoodsSkuAttr();
                    specAttr.setGoodsId(goods.getId());
                    specAttr.setType(attr!=null?attr.getCode(): "color");
                    specAttr.setK(attr!=null?attr.getTitle():"颜色");
                    specAttr.setKid(value.getCategoryAttributeId());
                    specAttr.setVid(val.toString());
                    skuAttrMapper.insert(specAttr);
                }
            }

        }
        if(goods.getSizeValues()!=null) {
            for (Long val:goods.getSizeValues()) {
                ErpGoodsCategoryAttributeValue value = attributeValueMapper.selectById(val);
                if(value!=null) {
                    ErpGoodsCategoryAttribute attr = attributeMapper.selectById(value.getCategoryAttributeId());
                    ErpGoodsSkuAttr specAttr = new ErpGoodsSkuAttr();
                    specAttr.setGoodsId(goods.getId());
                    specAttr.setType(attr!=null?attr.getCode():"size");
                    specAttr.setK(attr!=null?attr.getTitle():"尺码");
                    specAttr.setKid(value.getCategoryAttributeId());
                    specAttr.setVid(val.toString());
                    skuAttrMapper.insert(specAttr);
                }
            }

        }
        if(goods.getStyleValues()!=null) {
            for (Long val:goods.getStyleValues()) {
                ErpGoodsCategoryAttributeValue value = attributeValueMapper.selectById(val);
                if(value!=null) {
                    ErpGoodsCategoryAttribute attr = attributeMapper.selectById(value.getCategoryAttributeId());
                    ErpGoodsSkuAttr specAttr = new ErpGoodsSkuAttr();
                    specAttr.setGoodsId(goods.getId());
                    specAttr.setType(attr!=null?attr.getCode():"style");
                    specAttr.setK(attr!=null?attr.getTitle():"款式");
                    specAttr.setKid(value.getCategoryAttributeId());
                    specAttr.setVid(val.toString());
                    skuAttrMapper.insert(specAttr);
                }
            }

        }
//        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
        return 1;
    }

    @Transactional
    @Override
    public int deleteGoods(Long[] ids) {
        List<Long> idList = Arrays.stream(ids).toList();

        // 删除 erp_goods_sku_attr
        skuAttrMapper.delete(new LambdaQueryWrapper<ErpGoodsSkuAttr>().in(ErpGoodsSkuAttr::getGoodsId,idList));
        // 删除 erp_goods_sku
        skuMapper.delete(new LambdaQueryWrapper<ErpGoodsSku>().in(ErpGoodsSku::getGoodsId,idList));
        // 删除 erp_goods
        mapper.deleteBatchIds(idList);

        return 1;
    }
}




