package cn.qihangerp.api.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpLogisticsCompany;
import cn.qihangerp.api.mapper.ErpLogisticsCompanyMapper;
import cn.qihangerp.api.service.ErpLogisticsCompanyService;
import org.springframework.util.StringUtils;

import java.util.List;

/**
* @author TW
* @description 针对表【sys_logistics_company(平台快递公司表)】的数据库操作Service实现
* @createDate 2024-03-22 11:03:11
*/
@AllArgsConstructor
@Service
public class ErpLogisticsCompanyServiceImpl extends ServiceImpl<ErpLogisticsCompanyMapper, ErpLogisticsCompany>
    implements ErpLogisticsCompanyService {
    private final ErpLogisticsCompanyMapper mapper;

    @Override
    public PageResult<ErpLogisticsCompany> queryPageList(Long tenantId, Integer platform, Integer status, String name,PageQuery pageQuery) {
        LambdaQueryWrapper<ErpLogisticsCompany> queryWrapper = new LambdaQueryWrapper<ErpLogisticsCompany>()
                .eq(ErpLogisticsCompany::getTenantId,tenantId)
                .like(StringUtils.hasText(name),ErpLogisticsCompany::getName,name)
                .eq(platform != null, ErpLogisticsCompany::getPlatformId, platform)
                .eq(status != null, ErpLogisticsCompany::getStatus, status);

        Page<ErpLogisticsCompany> pages = mapper.selectPage(pageQuery.build(), queryWrapper);
        return PageResult.build(pages);
    }

    @Override
    public List<ErpLogisticsCompany> queryListByStatus(Long tenantId, Integer status, Integer shopType) {
        LambdaQueryWrapper<ErpLogisticsCompany> queryWrapper = new LambdaQueryWrapper<ErpLogisticsCompany>()
                .eq(ErpLogisticsCompany::getTenantId,tenantId)
                .eq(ErpLogisticsCompany::getStatus, status)
                .eq(shopType != null, ErpLogisticsCompany::getPlatformId, shopType);
        return mapper.selectList(queryWrapper);
    }

    @Override
    public int updateStatus(String id,Integer status) {
        ErpLogisticsCompany update = new ErpLogisticsCompany();
        update.setId(id);
        update.setStatus(status);
        return mapper.updateById(update);
    }

    @Override
    public int insert(ErpLogisticsCompany logisticsCompany) {
        List<ErpLogisticsCompany> sysLogisticsCompanies = mapper.selectList(new LambdaQueryWrapper<ErpLogisticsCompany>()
                .eq(ErpLogisticsCompany::getPlatformId, logisticsCompany.getPlatformId())
                .eq(ErpLogisticsCompany::getLogisticsId, logisticsCompany.getLogisticsId()));
        if (sysLogisticsCompanies == null || sysLogisticsCompanies.size() == 0) {
            return mapper.insert(logisticsCompany);
        }
        return 0;
    }

    @Override
    public ErpLogisticsCompany queryByCode(String code, Integer shopType) {

        List<ErpLogisticsCompany> erpLogisticsCompanies = mapper.selectList(new LambdaQueryWrapper<ErpLogisticsCompany>().eq(ErpLogisticsCompany::getCode, code).eq(ErpLogisticsCompany::getPlatformId, shopType));
        if (erpLogisticsCompanies == null || erpLogisticsCompanies.size() == 0) {
            return null;
        }else return erpLogisticsCompanies.get(0);
    }
}




