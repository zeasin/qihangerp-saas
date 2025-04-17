package cn.qihangerp.api.controller.shop;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.ShopRefund;
import cn.qihangerp.api.service.ShopRefundService;

@AllArgsConstructor
@RestController
@RequestMapping("/shop/refund")
public class ShopRefundController extends BaseController {
    private final ShopRefundService refundService;
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public TableDataInfo goodsList(ShopRefund bo, PageQuery pageQuery) {
        PageResult<ShopRefund> result = refundService.queryPageList(bo, pageQuery);

        return getDataTable(result);
    }


    @PutMapping("/returnedConfirm/{id}")
    public AjaxResult returnedConfirm(@PathVariable Long id)
    {
        refundService.returnedConfirm(id);

        return toAjax(1);
    }
    @PutMapping("/orderIntercept/{id}")
    public AjaxResult orderIntercept(@PathVariable Long id)
    {
        refundService.orderIntercept(id);

        return toAjax(1);
    }

}
