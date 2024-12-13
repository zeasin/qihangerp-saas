package cn.qihangerp.api.service;

import cn.qihangerp.api.domain.SysLicense;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【sys_license】的数据库操作Service
* @createDate 2024-12-13 17:50:09
*/
public interface SysLicenseService extends IService<SysLicense> {
    SysLicense getByUuid(String uuid);
    void save(String uuid,Long time);
}
