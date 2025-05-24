package cn.qihangerp.api.controller;

import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.ErpOrderShipList;
import cn.qihangerp.api.domain.ErpShipment;
import cn.qihangerp.api.request.SupplierAgentShipmentRequest;
import cn.qihangerp.api.service.ErpOrderShipListService;
import cn.qihangerp.api.service.ErpShipmentItemService;
import cn.qihangerp.api.service.ErpShipmentService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

@AllArgsConstructor
@RestController
@RequestMapping("/orderShip")
public class OrderShipSupplierController extends BaseController {
    private final ErpShipmentService shippingService;
    private final ErpOrderShipListService orderShipListService;
    /**
     * 备货中-供应商代发
     * @param bo
     * @param pageQuery
     * @return
     */
    @GetMapping("/supplier_shipment_list")
    public TableDataInfo supplierShipList(ErpOrderShipList bo, PageQuery pageQuery)
    {
        bo.setShipper(1);
        bo.setTenantId(getUserId());

        PageResult<ErpOrderShipList> erpShipmentPageResult = orderShipListService.queryPageList(bo, pageQuery);
        return getDataTable(erpShipmentPageResult);
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
