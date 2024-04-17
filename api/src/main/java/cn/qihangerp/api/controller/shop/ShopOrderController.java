package cn.qihangerp.api.controller.shop;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import cn.qihangerp.api.common.*;
import cn.qihangerp.api.common.bo.ShopOrderConfirmBo;
import cn.qihangerp.api.domain.WeiOrder;
import cn.qihangerp.api.service.WeiOrderService;

@AllArgsConstructor
@RestController
@RequestMapping("/shop/order")
public class ShopOrderController extends BaseController {
    private final WeiOrderService orderService;
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public TableDataInfo goodsList(WeiOrder bo, PageQuery pageQuery) {
        PageResult<WeiOrder> result = orderService.queryPageList(bo, pageQuery);

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
}
