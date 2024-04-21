package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpGoods;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ErpGoodsBrand;
import cn.qihangerp.api.service.ErpGoodsBrandService;
import cn.qihangerp.api.mapper.ErpGoodsBrandMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
* @author qilip
* @description 针对表【erp_goods_brand】的数据库操作Service实现
* @createDate 2024-04-21 12:24:52
*/
@AllArgsConstructor
@Service
public class ErpGoodsBrandServiceImpl extends ServiceImpl<ErpGoodsBrandMapper, ErpGoodsBrand>
    implements ErpGoodsBrandService{
    private final ErpGoodsBrandMapper mapper;

    @Override
    public PageResult<ErpGoodsBrand> queryPageList(ErpGoodsBrand bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpGoodsBrand> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ErpGoodsBrand::getTenantId,bo.getTenantId());
        queryWrapper.eq(StringUtils.hasText(bo.getName()),ErpGoodsBrand::getName,bo.getName());
        Page<ErpGoodsBrand> pages = mapper.selectPage(pageQuery.build(), queryWrapper);

        return PageResult.build(pages);
    }
}




