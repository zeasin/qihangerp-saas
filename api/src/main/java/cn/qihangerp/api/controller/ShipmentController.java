package cn.qihangerp.api.controller;

import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.ErpShipment;
import cn.qihangerp.api.domain.ErpShipmentItem;
import cn.qihangerp.api.request.StockShipmentStockOutRequest;
import cn.qihangerp.api.service.ErpShipmentItemService;
import cn.qihangerp.api.service.ErpShipmentService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

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
     * 详情
     * @param id
     * @return
     */
    @GetMapping(value = "/detail/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(shippingService.queryDetailById(id));
    }



}
