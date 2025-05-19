package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ErpShopTaskLogs;
import cn.qihangerp.api.service.ErpShopTaskLogsService;
import cn.qihangerp.api.mapper.ErpShopTaskLogsMapper;
import org.springframework.stereotype.Service;

/**
* @author qilip
* @description 针对表【erp_shop_task_logs(后台任务运行日志表)】的数据库操作Service实现
* @createDate 2025-05-19 15:04:38
*/
@Service
public class ErpShopTaskLogsServiceImpl extends ServiceImpl<ErpShopTaskLogsMapper, ErpShopTaskLogs>
    implements ErpShopTaskLogsService{
    @Override
    public PageResult<ErpShopTaskLogs> queryPageList(Integer taskId, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpShopTaskLogs> queryWrapper = new LambdaQueryWrapper<ErpShopTaskLogs>().eq(ErpShopTaskLogs::getTaskId,taskId);
        Page<ErpShopTaskLogs> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);
        return PageResult.build(pages);
    }
}




