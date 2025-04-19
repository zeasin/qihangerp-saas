package cn.qihangerp.api.service;

import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.domain.SysConfig;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【sys_config(参数配置表)】的数据库操作Service
* @createDate 2025-04-19 21:46:04
*/
public interface SysConfigService extends IService<SysConfig> {
    ResultVo<SysConfig> getSysConfigValue(String configKey);
    ResultVo<SysConfig> getSysConfigValue(String configKey, String keyWord);
}
