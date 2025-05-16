package cn.qihangerp.api.controller;

import cn.qihangerp.api.domain.ErpOrderItem;
import cn.qihangerp.api.domain.ErpShipmentItem;
import cn.qihangerp.api.service.ErpShipmentItemService;
import lombok.AllArgsConstructor;
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
     * 备货中-供应商代发
     * @param bo
     * @param pageQuery
     * @return
     */
    @GetMapping("/supplier_shipment_list")
    public TableDataInfo supplierShipList(ErpShipmentItem bo, PageQuery pageQuery)
    {
        bo.setShipper(1);
        bo.setStockStatus(0);
        bo.setTenantId(getUserId());
        PageResult<ErpShipmentItem> list = shippingItemService.queryPageList(bo, pageQuery);
        return getDataTable(list);
    }
}
