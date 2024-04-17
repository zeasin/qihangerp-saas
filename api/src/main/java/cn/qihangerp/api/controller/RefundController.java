package cn.qihangerp.api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import cn.qihangerp.api.common.AjaxResult;
import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.TableDataInfo;
import cn.qihangerp.api.domain.ErpRefund;
import cn.qihangerp.api.service.ErpRefundService;

/**
 * 退换货Controller
 * 
 * @author qihang
 * @date 2024-01-13
 */
@RestController
@RequestMapping("/refund")
public class RefundController extends BaseController
{
    @Autowired
    private ErpRefundService refundService;

    /**
     * 查询退换货列表
     */
    @GetMapping("/list")
    public TableDataInfo list(ErpRefund refund, PageQuery pageQuery)
    {
        var pageList = refundService.queryPageList(refund,pageQuery);
        return getDataTable(pageList);
    }


    /**
     * 获取退换货详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(refundService.getById(id));
    }


}
