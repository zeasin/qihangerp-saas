package cn.qihangerp.api.controller;

import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.ErpPurchaseOrderPayable;
import cn.qihangerp.api.service.ErpPurchaseOrderPayableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * 财务管理-应付款-采购货款Controller
 * 
 * @author qihang
 * @date 2024-01-28
 */
@RestController
@RequestMapping("/fms/payablePurchase")
public class PurchaseOrderPayableController extends BaseController
{
    @Autowired
    private ErpPurchaseOrderPayableService payableService;

    /**
     * 查询财务管理-应付款-采购货款列表
     */
    @PreAuthorize("@ss.hasPermi('fms:payablePurchase:list')")
    @GetMapping("/list")
    public TableDataInfo list(ErpPurchaseOrderPayable bo, PageQuery pageQuery)
    {
        bo.setTenantId(getUserId());
        PageResult<ErpPurchaseOrderPayable> pageResult = payableService.queryPageList(bo, pageQuery);
        return getDataTable(pageResult);
    }


    /**
     * 获取财务管理-应付款-采购货款详细信息
     */
    @PreAuthorize("@ss.hasPermi('fms:payablePurchase:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(payableService.getById(id));
    }



    /**
     * 修改财务管理-应付款-采购货款
     */
    @PreAuthorize("@ss.hasPermi('fms:payablePurchase:edit')")
    @PutMapping
    public AjaxResult edit(@RequestBody ErpPurchaseOrderPayable bo)
    {
        return toAjax(payableService.updateById(bo));
    }

    /**
     * 删除财务管理-应付款-采购货款
     */
//    @PreAuthorize("@ss.hasPermi('fms:payablePurchase:remove')")
//    @Log(title = "财务管理-应付款-采购货款", businessType = BusinessType.DELETE)
//	@DeleteMapping("/{ids}")
//    public AjaxResult remove(@PathVariable Long[] ids)
//    {
//        return toAjax(fmsPayablePurchaseService.deleteFmsPayablePurchaseByIds(ids));
//    }
}
