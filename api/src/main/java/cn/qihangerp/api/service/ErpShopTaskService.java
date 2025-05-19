package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpShopTask;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【erp_shop_task(后台任务配置表)】的数据库操作Service
* @createDate 2025-05-19 15:04:38
*/
public interface ErpShopTaskService extends IService<ErpShopTask> {
    PageResult<ErpShopTask> queryPageList(PageQuery pageQuery);
}
