package cn.qihangerp.api.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.LogisticsCompany;
import cn.qihangerp.api.mapper.LogisticsCompanyMapper;
import cn.qihangerp.api.service.LogisticsCompanyService;

import java.util.List;

/**
* @author TW
* @description 针对表【sys_logistics_company(平台快递公司表)】的数据库操作Service实现
* @createDate 2024-03-22 11:03:11
*/
@AllArgsConstructor
@Service
public class LogisticsCompanyServiceImpl extends ServiceImpl<LogisticsCompanyMapper, LogisticsCompany>
    implements LogisticsCompanyService {
    private final LogisticsCompanyMapper mapper;

    @Override
    public PageResult<LogisticsCompany> queryPageList(Long tenantId, Integer platform, Integer shopId, PageQuery pageQuery) {
        LambdaQueryWrapper<LogisticsCompany> queryWrapper = new LambdaQueryWrapper<LogisticsCompany>()
                .eq(LogisticsCompany::getTenantId,tenantId)
                .eq(platform != null, LogisticsCompany::getPlatformId, platform)
                .eq(shopId != null, LogisticsCompany::getShopId, shopId);

        Page<LogisticsCompany> pages = mapper.selectPage(pageQuery.build(), queryWrapper);
        return PageResult.build(pages);
    }

    @Override
    public List<LogisticsCompany> queryListByStatus(Integer status, Integer shopId) {
        LambdaQueryWrapper<LogisticsCompany> queryWrapper = new LambdaQueryWrapper<LogisticsCompany>().
                eq(LogisticsCompany::getStatus, status)
                .eq(shopId != null, LogisticsCompany::getShopId, shopId);
        return mapper.selectList(queryWrapper);
    }

    @Override
    public int updateStatus(String id,Integer status) {
        LogisticsCompany update = new LogisticsCompany();
        update.setId(id);
        update.setStatus(status);
        return mapper.updateById(update);
    }
}




