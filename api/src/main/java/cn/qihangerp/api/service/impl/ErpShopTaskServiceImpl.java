package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ErpShopTask;
import cn.qihangerp.api.service.ErpShopTaskService;
import cn.qihangerp.api.mapper.ErpShopTaskMapper;
import org.springframework.stereotype.Service;

/**
* @author qilip
* @description 针对表【erp_shop_task(后台任务配置表)】的数据库操作Service实现
* @createDate 2025-05-19 15:04:38
*/
@Service
public class ErpShopTaskServiceImpl extends ServiceImpl<ErpShopTaskMapper, ErpShopTask>
    implements ErpShopTaskService{

    @Override
    public PageResult<ErpShopTask> queryPageList(PageQuery pageQuery) {
        LambdaQueryWrapper<ErpShopTask> queryWrapper = new LambdaQueryWrapper<ErpShopTask>();

        Page<ErpShopTask> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);
        return PageResult.build(pages);
    }
}




