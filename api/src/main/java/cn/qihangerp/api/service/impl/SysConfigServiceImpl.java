package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.ResultVo;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.SysConfig;
import cn.qihangerp.api.service.SysConfigService;
import cn.qihangerp.api.mapper.SysConfigMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author qilip
* @description 针对表【sys_config(参数配置表)】的数据库操作Service实现
* @createDate 2025-04-19 21:46:04
*/
@Service
public class SysConfigServiceImpl extends ServiceImpl<SysConfigMapper, SysConfig>
    implements SysConfigService{
    @Override
    public ResultVo<SysConfig> getSysConfigValue(String configKey) {
        List<SysConfig> sysConfigs = this.baseMapper.selectList(new LambdaQueryWrapper<SysConfig>().eq(SysConfig::getConfigKey, configKey));
        if(sysConfigs!=null&&sysConfigs.size()>0){
            return ResultVo.success(sysConfigs.get(0));
        }
        return ResultVo.error();
    }

    @Override
    public ResultVo<SysConfig> getSysConfigValue(String configKey, String keyWord) {
        List<SysConfig> sysConfigs = this.baseMapper.selectList(new LambdaQueryWrapper<SysConfig>()
                .eq(SysConfig::getConfigKey, configKey)
                .like(SysConfig::getConfigName, keyWord)
        );
        if(sysConfigs!=null&&sysConfigs.size()>0){
            return ResultVo.success(sysConfigs.get(0));
        }
        return ResultVo.error();
    }
}




