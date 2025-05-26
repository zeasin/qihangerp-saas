package cn.qihangerp.api.controller.shop;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.ShopRefund;
import cn.qihangerp.api.service.ShopRefundService;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/shop/refund")
public class ShopRefundController extends BaseController {
    private final ShopRefundService refundService;
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public TableDataInfo goodsList(ShopRefund bo, PageQuery pageQuery) {
        bo.setTenantId(getUserId());
        PageResult<ShopRefund> result = refundService.queryPageList(bo, pageQuery);

        return getDataTable(result);
    }

    /**
     * 退货确认（退货退款的订单才可以）
     * @param id
     * @return
     */
    @PutMapping("/returnedConfirm/{id}")
    public AjaxResult returnedConfirm(@PathVariable Long id)
    {
        log.info("===============退货确认==========");
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
