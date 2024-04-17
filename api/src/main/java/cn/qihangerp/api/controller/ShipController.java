package cn.qihangerp.api.controller;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.TableDataInfo;
import cn.qihangerp.api.domain.ErpOrder;
import cn.qihangerp.api.domain.ErpOrderItem;
import cn.qihangerp.api.domain.SysShop;
import cn.qihangerp.api.mapper.ErpOrderItemMapper;
import cn.qihangerp.api.service.ErpOrderItemService;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping("/shipping")
public class ShipController extends BaseController {
    private final ErpOrderItemService erpOrderItemService;

    /**
     * 备货中-仓库发货
     * @param bo
     * @param pageQuery
     * @return
     */
    @GetMapping("/stock_ship_list")
    public TableDataInfo stockShipList(ErpOrderItem bo, PageQuery pageQuery)
    {
        PageResult<ErpOrderItem> list = erpOrderItemService.queryPageList(0,1,bo, pageQuery);
        return getDataTable(list);
    }
    /**
     * 备货中-供应商代发
     * @param bo
     * @param pageQuery
     * @return
     */
    @GetMapping("/supplier_ship_list")
    public TableDataInfo supplierShipList(ErpOrderItem bo, PageQuery pageQuery)
    {
        PageResult<ErpOrderItem> list = erpOrderItemService.queryPageList(1,1,bo, pageQuery);
        return getDataTable(list);
    }

}
