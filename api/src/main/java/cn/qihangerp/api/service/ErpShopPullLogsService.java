package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpShopPullLogs;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【erp_shop_pull_logs(更新日志表)】的数据库操作Service
* @createDate 2024-04-24 21:54:36
*/
public interface ErpShopPullLogsService extends IService<ErpShopPullLogs> {
    PageResult<ErpShopPullLogs> queryPageList(ErpShopPullLogs bo, PageQuery pageQuery);
}
