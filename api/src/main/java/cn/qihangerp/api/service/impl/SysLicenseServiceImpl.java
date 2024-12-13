package cn.qihangerp.api.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.SysLicense;
import cn.qihangerp.api.service.SysLicenseService;
import cn.qihangerp.api.mapper.SysLicenseMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
* @author qilip
* @description 针对表【sys_license】的数据库操作Service实现
* @createDate 2024-12-13 17:50:09
*/
@AllArgsConstructor
@Service
public class SysLicenseServiceImpl extends ServiceImpl<SysLicenseMapper, SysLicense>
    implements SysLicenseService{
    private final SysLicenseMapper sysLicenseMapper;

    @Override
    public SysLicense getByUuid(String uuid) {
        List<SysLicense> list = sysLicenseMapper.selectList(new LambdaQueryWrapper<SysLicense>().eq(SysLicense::getUuid, uuid));
        if (list.size() > 0) {
            return list.get(0);
        }
        return null;
    }

    @Override
    public void save(String uuid, Long time) {
        SysLicense byUuid = getByUuid(uuid);
        if (byUuid == null) {
            // 新增
            // 插入数据
            SysLicense license = new SysLicense();
            license.setUuid(uuid);
            license.setTime(time);
            license.setStatus(0);
            license.setStartupCount(1);
            license.setCreateTime(new Date());
            license.setUpdateTime(new Date());
            sysLicenseMapper.insert(license);
        }else {
            // 修改
            SysLicense update = new SysLicense();
            update.setId(byUuid.getId());
            update.setStartupCount(byUuid.getStartupCount()+1);
            update.setUpdateTime(new Date());
            sysLicenseMapper.updateById(update);
        }
    }
}




