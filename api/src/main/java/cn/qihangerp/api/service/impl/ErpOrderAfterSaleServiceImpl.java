package cn.qihangerp.api.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpOrderAfterSale;
import cn.qihangerp.api.service.ErpOrderAfterSaleService;
import cn.qihangerp.api.mapper.ErpOrderAfterSaleMapper;
import org.springframework.stereotype.Service;

/**
* @author qilip
* @description 针对表【erp_after_sale(售后处理表)】的数据库操作Service实现
* @createDate 2024-04-05 21:24:00
*/
@AllArgsConstructor
@Service
public class ErpOrderAfterSaleServiceImpl extends ServiceImpl<ErpOrderAfterSaleMapper, ErpOrderAfterSale>
    implements ErpOrderAfterSaleService {
    private final ErpOrderAfterSaleMapper mapper;
    @Override
    public PageResult<ErpOrderAfterSale> queryPageList(ErpOrderAfterSale bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpOrderAfterSale> queryWrapper = new LambdaQueryWrapper<ErpOrderAfterSale>().
                eq( ErpOrderAfterSale::getType, bo.getType())
                .eq(bo.getShopId() != null, ErpOrderAfterSale::getShopId, bo.getShopId());

        Page<ErpOrderAfterSale> pages = mapper.selectPage(pageQuery.build(), queryWrapper);
        return PageResult.build(pages);
    }
}




