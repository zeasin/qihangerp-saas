package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ErpSupplier;
import cn.qihangerp.api.service.ErpSupplierService;
import cn.qihangerp.api.mapper.ErpSupplierMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/**
* @author qilip
* @description 针对表【erp_supplier】的数据库操作Service实现
* @createDate 2024-04-21 16:16:24
*/
@AllArgsConstructor
@Service
public class ErpSupplierServiceImpl extends ServiceImpl<ErpSupplierMapper, ErpSupplier>
    implements ErpSupplierService{
    private final ErpSupplierMapper mapper;
    @Override
    public PageResult<ErpSupplier> queryPageList(ErpSupplier bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpSupplier> queryWrapper = new LambdaQueryWrapper<ErpSupplier>()
                .eq(bo.getTenantId()!=null,ErpSupplier::getTenantId,bo.getTenantId());

        Page<ErpSupplier> pages = mapper.selectPage(pageQuery.build(), queryWrapper);

        return PageResult.build(pages);
    }
}




