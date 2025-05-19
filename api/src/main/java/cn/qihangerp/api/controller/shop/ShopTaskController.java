package cn.qihangerp.api.controller.shop;

import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.ErpShopTask;
import cn.qihangerp.api.service.ErpShopTaskLogsService;
import cn.qihangerp.api.service.ErpShopTaskService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 *
 * 
 * @author qihang
 */
@AllArgsConstructor
@RestController
@RequestMapping("/shop/task")
public class ShopTaskController extends BaseController
{
    private final ErpShopTaskService taskService;
    private final ErpShopTaskLogsService taskLogsService;
    @GetMapping("/list")
    public TableDataInfo list(PageQuery pageQuery)
    {
        PageResult<ErpShopTask> pageResult = taskService.queryPageList(pageQuery);
        return getDataTable(pageResult);
    }

    @GetMapping(value = "/{taskId}")
    public AjaxResult getInfo(@PathVariable Long taskId)
    {
        return success(taskService.getById(taskId));
    }

    @GetMapping(value = "/logs/{taskId}")
    public AjaxResult getLogs(@PathVariable Integer taskId)
    {
        return success(taskLogsService.queryPageList(taskId,new PageQuery()));
    }

    @PutMapping
    public AjaxResult edit(@RequestBody ErpShopTask task)
    {
        return toAjax(taskService.updateById(task));
    }
}
