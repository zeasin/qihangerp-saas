package cn.qihangerp.api.controller;

import cn.qihangerp.api.common.AjaxResult;
import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.TableDataInfo;
import cn.qihangerp.api.domain.ErpPurchaseOrderShip;
import cn.qihangerp.api.domain.bo.PurchaseOrderStockInBo;
import cn.qihangerp.api.service.ErpPurchaseOrderShipService;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 采购订单物流Controller
 * 
 * @author qihang
 * @date 2023-12-30
 */
@AllArgsConstructor
@RestController
@RequestMapping("/purchase/PurchaseOrderShip")
public class PurchaseOrderShipController extends BaseController
{

    private final ErpPurchaseOrderShipService shipService;

    /**
     * 查询采购订单物流列表
     */
    @GetMapping("/list")
    public TableDataInfo list(ErpPurchaseOrderShip bo, PageQuery pageQuery)
    {
        bo.setTenantId(getUserId());
        var list = shipService.queryPageList(bo,pageQuery);
        return getDataTable(list);
    }


    /**
     * 获取采购订单物流详细信息
     */
    @PreAuthorize("@ss.hasPermi('purchase:PurchaseOrderShip:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(shipService.getById(id));
    }

    /**
     * 确认收货
     */
    @PreAuthorize("@ss.hasPermi('purchase:PurchaseOrderShip:edit')")
    @PutMapping
    public AjaxResult confirmReceipt(@RequestBody ErpPurchaseOrderShip bo)
    {
        bo.setTenantId(getUserId());
        bo.setUpdateBy(getUsername());
        return toAjax(shipService.confirmPurchaseOrderShip(bo));
    }

//    @PostMapping("/createStockInEntry")
//    public AjaxResult createStockInEntry(@RequestBody PurchaseOrderStockInBo bo)
//    {
//        bo.setCreateBy(getUsername());
//        int result = shipService.createStockInEntry(bo);
//        if(result == -1) return new AjaxResult(1404,"采购物流不存在");
//        else if (result == -2) return new AjaxResult(501,"未确认收货不允许操作");
//        else if (result == -3) {
//            return new AjaxResult(502,"已处理过了请勿重复操作");
//        } else if (result == -4) {
//            return new AjaxResult(503,"状态不正确不能操作");
//        } else if (result == 1) {
//            return toAjax(1);
//        }else return toAjax(result);
//    }


}
