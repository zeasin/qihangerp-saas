package cn.qihangerp.api.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpGoods;
import cn.qihangerp.api.domain.ErpGoodsCategory;
import cn.qihangerp.api.service.ErpGoodsCategoryService;
import cn.qihangerp.api.mapper.ErpGoodsCategoryMapper;
import org.springframework.stereotype.Service;

/**
* @author TW
* @description 针对表【erp_goods_category】的数据库操作Service实现
* @createDate 2024-04-12 15:01:52
*/
@AllArgsConstructor
@Service
public class ErpGoodsCategoryServiceImpl extends ServiceImpl<ErpGoodsCategoryMapper, ErpGoodsCategory>
    implements ErpGoodsCategoryService{
    private final ErpGoodsCategoryMapper mapper;

    @Override
    public PageResult<ErpGoodsCategory> queryPageList(ErpGoodsCategory bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpGoodsCategory> queryWrapper = new LambdaQueryWrapper<>();
//        queryWrapper.eq(bo.getErpSkuId()!=null,OGoodsSku::getErpSkuId,bo.getErpSkuId());
//        queryWrapper.eq(bo.getErpGoodsId()!=null,OGoodsSku::getErpGoodsId,bo.getErpGoodsId());
//        queryWrapper.eq(StringUtils.hasText(bo.getSkuNum()),OGoodsSku::getSkuNum,bo.getSkuNum());
        Page<ErpGoodsCategory> pages = mapper.selectPage(pageQuery.build(), queryWrapper);

        return PageResult.build(pages);
    }
}




