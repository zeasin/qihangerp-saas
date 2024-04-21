package cn.qihangerp.api.controller;

import cn.qihangerp.api.common.TableDataInfo;
import cn.qihangerp.api.domain.ErpPurchaseOrderItem;
import cn.qihangerp.api.service.ErpPurchaseOrderItemService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import cn.qihangerp.api.common.BaseController;
import java.util.List;

/**
 * 采购订单明细Controller
 * 
 * @author qihang
 * @date 2023-12-29
 */
@RestController
@RequestMapping("/purchase")
public class PurchaseOrderItemController extends BaseController
{
    @Autowired
    private ErpPurchaseOrderItemService itemService;

    /**
     * 查询采购订单明细列表
     */
    @PreAuthorize("@ss.hasPermi('purchase:purchaseOrderItem:list')")
    @GetMapping("/purchaseOrderItem/list")
    public TableDataInfo list(ErpPurchaseOrderItem bo)
    {

        List<ErpPurchaseOrderItem> list = itemService.list(new LambdaQueryWrapper<ErpPurchaseOrderItem>().eq(ErpPurchaseOrderItem::getTenantId,getUserId()).eq(ErpPurchaseOrderItem::getOrderId,bo.getOrderId()));
        return getDataTable(list);
    }


}
