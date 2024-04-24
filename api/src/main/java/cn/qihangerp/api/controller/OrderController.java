package cn.qihangerp.api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import cn.qihangerp.api.common.AjaxResult;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.common.TableDataInfo;
import cn.qihangerp.api.common.bo.ErpOrderShipBo;
import cn.qihangerp.api.domain.ErpOrder;
import cn.qihangerp.api.service.ErpOrderService;

/**
 * 店铺订单Controller
 *
 * @author qihang
 * @date 2023-12-31
 */
@RestController
@RequestMapping("/order")
public class OrderController extends BaseController
{
    @Autowired
    private ErpOrderService orderService;

    /**
     * 查询店铺订单列表
     */
    @PreAuthorize("@ss.hasPermi('shop:order:list')")
    @GetMapping("/list")
    public TableDataInfo list(ErpOrder order, PageQuery pageQuery)
    {
        order.setTenantId(getUserId());
        var pageList = orderService.queryPageList(order,pageQuery);
        return getDataTable(pageList);
    }


    /**
     * 获取订单详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(orderService.getById(id));
    }


    /**
     * 订单发货
     * @param shipBo
     * @return
     */
    @PostMapping("/ship")
    public AjaxResult ship(@RequestBody ErpOrderShipBo shipBo)
    {
        var result = orderService.shipErpOrder(shipBo);
        if(result.getCode() == -1) return new AjaxResult(501,"订单不存在！");
        else if(result.getCode() == -2) return new AjaxResult(502,"订单号已存在！");
        return toAjax(result.getCode());
    }

}
