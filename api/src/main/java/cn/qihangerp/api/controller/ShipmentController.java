package cn.qihangerp.api.controller;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.ErpShipment;
import cn.qihangerp.api.service.ErpOrderShippingService;

@AllArgsConstructor
@RestController
@RequestMapping("/shipping")
public class ShipmentController extends BaseController {
    private final ErpOrderShippingService shippingService;
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
}
