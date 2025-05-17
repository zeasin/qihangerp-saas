package cn.qihangerp.api.controller;

import cn.qihangerp.api.domain.ErpShipmentItem;
import cn.qihangerp.api.request.StockOutCreateRequest;
import cn.qihangerp.api.request.StockShipmentStockOutRequest;
import cn.qihangerp.api.request.SupplierAgentShipmentRequest;
import cn.qihangerp.api.service.ErpShipmentItemService;
import lombok.AllArgsConstructor;
import org.checkerframework.checker.units.qual.A;
import org.springframework.web.bind.annotation.*;
import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.ErpShipment;
import cn.qihangerp.api.service.ErpShipmentService;

@AllArgsConstructor
@RestController
@RequestMapping("/shipping")
public class ShipmentController extends BaseController {
    private final ErpShipmentService shippingService;
    private final ErpShipmentItemService shippingItemService;

    @GetMapping("/list")
    public TableDataInfo list(ErpShipment shipping, PageQuery pageQuery)
    {
        shipping.setTenantId(getUserId());
        return getDataTable(shippingService.queryPageList(shipping,pageQuery));
    }
//    @PostMapping("/handShip")
//    public AjaxResult add(@RequestBody ErpOrderShipping shipping)
//    {
//        shipping.setShipType(1);
//        var result = shippingService.handShip(shipping);
//        if(result.getCode() == ResultVoEnum.SUCCESS.getIndex()) {
//            return AjaxResult.success();
//        }else{
//            return AjaxResult.error(result.getCode(),result.getMsg());
//        }
//    }

    /**
     * 备货中-仓库发货
     * @param bo
     * @param pageQuery
     * @return
     */
    @GetMapping("/stock_shipment_list")
    public TableDataInfo stockShipList(ErpShipmentItem bo, PageQuery pageQuery)
    {
        bo.setShipper(0);
        bo.setStockStatus(0);
        bo.setTenantId(getUserId());
        PageResult<ErpShipmentItem> list = shippingItemService.queryPageList(bo, pageQuery);
        return getDataTable(list);
    }

    /**
     * 仓库发货-确认出库
     * @param request
     * @return
     */
    @PostMapping("/stock_out_confirm")
    public AjaxResult stockOutConfirm(@RequestBody StockShipmentStockOutRequest request)
    {
//        ResultVo<Long> resultVo = stockOutService.createEntry(getUserId(), getUsername(), request);
//        if(resultVo.getCode()==0)
//            return AjaxResult.success();
//        else return AjaxResult.error(resultVo.getMsg());
        return AjaxResult.error("未实现");
    }

    /**
     * 备货中-供应商代发
     * @param bo
     * @param pageQuery
     * @return
     */
    @GetMapping("/supplier_shipment_list")
    public TableDataInfo supplierShipList(ErpShipment bo, PageQuery pageQuery)
    {
//        bo.setShipper(1);
//        bo.setStockStatus(0);
//        bo.setTenantId(getUserId());
//        PageResult<ErpShipmentItem> list = shippingItemService.queryPageList(bo, pageQuery);
//        return getDataTable(list);
        bo.setShipper(1);
        bo.setTenantId(getUserId());
        PageResult<ErpShipment> erpShipmentPageResult = shippingService.queryPageList(bo, pageQuery);
        return getDataTable(erpShipmentPageResult);
    }


    /**
     * 详情
     * @param id
     * @return
     */
    @GetMapping(value = "/detail/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(shippingService.queryDetailById(id));
    }

    /**
     * 供应商发货(供应商代发货)
     * @param shipping
     * @return
     */
    @PostMapping("/supplierAgentShipment")
    public AjaxResult supplierAgentShipment(@RequestBody SupplierAgentShipmentRequest shipping)
    {
//        shipping.setShipType(1);
        var result = shippingService.supplierAgentShipment(shipping);
        if(result.getCode() == ResultVoEnum.SUCCESS.getIndex()) {
            return AjaxResult.success();
        }else{
            return AjaxResult.error(result.getCode(),result.getMsg());
        }
    }

}
