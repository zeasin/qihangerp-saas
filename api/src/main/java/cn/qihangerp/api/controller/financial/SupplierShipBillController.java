package cn.qihangerp.api.controller.financial;

import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.ErpBillShipment;
import cn.qihangerp.api.domain.ErpBillShopOrder;
import cn.qihangerp.api.domain.Shop;
import cn.qihangerp.api.service.ErpBillShipmentService;
import cn.qihangerp.api.service.ErpBillShopOrderService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/financial")
public class SupplierShipBillController extends BaseController {
    private final ErpBillShipmentService erpBillShipmentService;
    /**
     * 供应商发货账单
     */
    @GetMapping("/supplier_ship_bill/list")
    public TableDataInfo list(ErpBillShipment goods, PageQuery pageQuery)
    {
        if(getUserId()!=1) {
            goods.setTenantId(getUserId());
        }
        PageResult<ErpBillShipment> pageResult = erpBillShipmentService.querySupplierPageList(goods, pageQuery);
        return getDataTable(pageResult);
    }

    @PostMapping("/supplier_ship_bill/confirmBillSettlement/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        for(Long id:ids) {
            ErpBillShipment bill = erpBillShipmentService.getById(id);
            if(bill != null) {
                if(bill.getTenantId()==getUserId()){
                    if(bill.getStatus()==0){
                        ErpBillShipment update =new ErpBillShipment();
                        update.setId(bill.getId());
                        update.setStatus(1);
                        update.setUpdateTime(new Date());
                        update.setUpdateBy("批量确认结算"+getUsername());
                        erpBillShipmentService.updateById(update);
                    }
                }
            }
        }
            return AjaxResult.success();

    }
}
