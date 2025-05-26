package cn.qihangerp.api.controller.financial;

import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.TableDataInfo;
import cn.qihangerp.api.domain.ErpBillShipment;
import cn.qihangerp.api.domain.ErpBillShopOrder;
import cn.qihangerp.api.service.ErpBillShipmentService;
import cn.qihangerp.api.service.ErpBillShopOrderService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
        PageResult<ErpBillShipment> pageResult = erpBillShipmentService.queryPageList(goods, pageQuery);
        return getDataTable(pageResult);
    }
}
