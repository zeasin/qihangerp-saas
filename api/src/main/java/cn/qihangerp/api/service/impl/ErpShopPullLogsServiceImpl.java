package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ErpShopPullLogs;
import cn.qihangerp.api.service.ErpShopPullLogsService;
import cn.qihangerp.api.mapper.ErpShopPullLogsMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
* @author qilip
* @description 针对表【erp_shop_pull_logs(更新日志表)】的数据库操作Service实现
* @createDate 2024-04-24 21:54:36
*/
@AllArgsConstructor
@Service
public class ErpShopPullLogsServiceImpl extends ServiceImpl<ErpShopPullLogsMapper, ErpShopPullLogs>
    implements ErpShopPullLogsService{
    private final ErpShopPullLogsMapper mapper;
    @Override
    public PageResult<ErpShopPullLogs> queryPageList(ErpShopPullLogs bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpShopPullLogs> queryWrapper = new LambdaQueryWrapper<ErpShopPullLogs>()
                .eq(ErpShopPullLogs::getTenantId,bo.getTenantId())
        .eq(bo.getShopId()!=null,ErpShopPullLogs::getShopId,bo.getShopId())
        .eq(bo.getShopType()!=null,ErpShopPullLogs::getShopType,bo.getShopType())
        .eq(StringUtils.hasText(bo.getPullType()),ErpShopPullLogs::getPullType,bo.getPullType());

        Page<ErpShopPullLogs> pages = mapper.selectPage(pageQuery.build(), queryWrapper);

        return PageResult.build(pages);
    }
}




