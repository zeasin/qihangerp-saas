package cn.qihangerp.api.controller;

import cn.qihangerp.api.domain.ErpShipmentItem;
import cn.qihangerp.api.request.StockShipmentStockOutRequest;
import cn.qihangerp.api.service.ErpOrderShipListService;
import cn.qihangerp.api.service.ErpShipmentItemService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import cn.qihangerp.api.common.*;
import cn.qihangerp.api.service.ErpShipmentService;

@AllArgsConstructor
@RestController
@RequestMapping("/orderShip")
public class OrderShipWarehouseController extends BaseController {
    private final ErpOrderShipListService erpOrderShipListService;
    private final ErpShipmentService shippingService;
    private final ErpShipmentItemService shippingItemService;


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
        if(request.getIds()==null || request.getIds().length==0) return AjaxResult.error("请选择出库的备货订单明细");
        ResultVo resultVo = shippingItemService.stockOutConfirm(request, getUsername(), getUserId());

        if(resultVo.getCode()==0)
            return AjaxResult.success();
        else return AjaxResult.error(resultVo.getMsg());

    }

    /**
     * 详情
     * @param id
     * @return
     */
    @GetMapping(value = "/detail/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(erpOrderShipListService.queryDetailById(id));
    }




}
