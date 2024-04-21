package cn.qihangerp.api.controller;

import cn.qihangerp.api.common.AjaxResult;
import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.TableDataInfo;
import cn.qihangerp.api.domain.ErpOrder;
import cn.qihangerp.api.domain.ErpPurchaseOrder;
import cn.qihangerp.api.domain.bo.PurchaseOrderAddBo;
import cn.qihangerp.api.domain.bo.PurchaseOrderOptionBo;
import cn.qihangerp.api.service.ErpPurchaseOrderService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

@AllArgsConstructor
@RestController
@RequestMapping("/purchase")
public class PurchaseOrderController extends BaseController {
    private final ErpPurchaseOrderService purchaseOrderService;

    @GetMapping("/purchaseOrder/list")
    public TableDataInfo list(ErpPurchaseOrder order, PageQuery pageQuery)
    {
        order.setTenantId(getUserId());
        var pageList = purchaseOrderService.queryPageList(order,pageQuery);
        return getDataTable(pageList);
    }

    /**
     * 添加采购单
     * @param addBo
     * @return
     */
    @PostMapping("/purchaseOrder")
    public AjaxResult add(@RequestBody PurchaseOrderAddBo addBo)
    {
        addBo.setTenantId(getUserId());
        addBo.setCreateBy(getUsername());
        return toAjax(purchaseOrderService.insertScmPurchaseOrder(addBo));
    }


    /**
     * 采购单状态修改
     * @param scmPurchaseOrder
     * @return
     */
    @PutMapping("/purchaseOrder")
    public AjaxResult edit(@RequestBody PurchaseOrderOptionBo scmPurchaseOrder)
    {
        scmPurchaseOrder.setUpdateBy(getUsername());
        int result = purchaseOrderService.updateScmPurchaseOrder(scmPurchaseOrder);
        if(result == -1){
            return new AjaxResult(0,"状态不正确");
        }else{
            return toAjax(result);
        }
    }

    @GetMapping(value = "/purchaseOrder/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        ErpPurchaseOrder order = purchaseOrderService.getById(id);
        return success(order);
    }

}
