package cn.qihangerp.api.controller;

import cn.qihangerp.api.common.bo.ErpOrderAllocateShipBo;
import cn.qihangerp.api.request.OrderSearchRequest;
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
     * 查询订单列表
     */
    @PreAuthorize("@ss.hasPermi('shop:order:list')")
    @GetMapping("/list")
    public TableDataInfo list(OrderSearchRequest order, PageQuery pageQuery)
    {
        if(getUserId()!=1) {
            order.setTenantId(getUserId());
        }
        var pageList = orderService.queryPageList(order,pageQuery);
        return getDataTable(pageList);
    }

    @GetMapping("/waitSelfShipmentList")
    public TableDataInfo queryWaitSelfShipmentPageList(OrderSearchRequest order, PageQuery pageQuery)
    {
        if(getUserId()!=1) {
            order.setTenantId(getUserId());
        }
        var pageList = orderService.queryWaitSelfShipmentPageList(order,pageQuery);
        return getDataTable(pageList);
    }


    /**
     * 获取订单详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        ErpOrder erpOrder = orderService.queryDetailById(id);

        return success(erpOrder);
    }


    /**
     * 订单发货(手动发货)
     * @param shipBo
     * @return
     */
    @PostMapping("/manualShipment")
    public AjaxResult manualShipment(@RequestBody ErpOrderShipBo shipBo)
    {
        var result = orderService.manualShipmentOrder(shipBo,getUsername());
        if(result.getCode() == 0) return AjaxResult.success();
        else return AjaxResult.error(result.getMsg());
    }

    /**
     * 分配供应商发货
     * @param shipBo
     * @return
     */
    @PostMapping("/allocateShipmentOrder")
    public AjaxResult allocateShipmentOrder(@RequestBody ErpOrderAllocateShipBo shipBo)
    {
        var result = orderService.allocateShipmentOrder(shipBo,getUsername());
        if(result.getCode() == 0) return AjaxResult.success();
        else return AjaxResult.error(result.getMsg());
    }



}
