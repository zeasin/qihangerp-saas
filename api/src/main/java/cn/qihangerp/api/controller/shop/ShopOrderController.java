package cn.qihangerp.api.controller.shop;

import cn.qihangerp.api.request.ShopOrderCreateBo;
import cn.qihangerp.api.request.ShopOrderSearchRequest;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import cn.qihangerp.api.common.*;
import cn.qihangerp.api.common.bo.ShopOrderConfirmBo;
import cn.qihangerp.api.domain.ShopOrder;
import cn.qihangerp.api.service.ShopOrderService;

@AllArgsConstructor
@RestController
@RequestMapping("/shop/order")
public class ShopOrderController extends BaseController {
    private final ShopOrderService orderService;
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public TableDataInfo goodsList(ShopOrderSearchRequest bo, PageQuery pageQuery) {
        bo.setTenantId(getUserId());
        PageResult<ShopOrder> result = orderService.queryPageList(bo, pageQuery);

        return getDataTable(result);
    }

    @PostMapping("/confirm")
    @ResponseBody
    public AjaxResult orderConfirm(@RequestBody ShopOrderConfirmBo bo) {
        if(bo!=null && bo.getIds()!=null) {
            ResultVo<Integer> resultVo = orderService.orderConfirm(bo.getIds());

            return success(resultVo.getData());
        }else{
            return AjaxResult.error("没有选择任何订单！");
        }
    }

    @PostMapping
    public AjaxResult add(@RequestBody ShopOrderCreateBo order)
    {
        if(order.getGoodsAmount()==null)return new AjaxResult(1503,"请填写商品价格！");
        order.setTenantId(getUserId());
        var result = orderService.insertOrder(order,getUsername());
        if(result.getCode()==0) return AjaxResult.success();
        else return AjaxResult.error(result.getMsg());
    }
}
