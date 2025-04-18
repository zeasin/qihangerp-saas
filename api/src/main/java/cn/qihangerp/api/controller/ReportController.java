package cn.qihangerp.api.controller;


import cn.qihangerp.api.common.AjaxResult;
import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.domain.Shop;
import cn.qihangerp.api.domain.vo.SalesDailyVo;
import cn.qihangerp.api.service.ErpOrderService;
import cn.qihangerp.api.service.ShopService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@AllArgsConstructor
@RestController
@RequestMapping("/report")
public class ReportController extends BaseController {
    private final ErpOrderService orderService;
//    private final OOrderItemService orderItemService;
    private final ShopService shopService;
//    private final OGoodsInventoryService inventoryService;
    @GetMapping("/todayDaily")
    public AjaxResult todayDaily()
    {
        Shop shop = new Shop();
        if (getUserId() != 1) {
            shop.setTenantId(getUserId());
        }
        List<Shop> list = shopService.selectShopList(shop);
        Long shopCount = list.stream().count();

        Map<String,Double> result = new HashMap<>();
        // 今日销售
        SalesDailyVo todaySalesDaily = orderService.getTodaySalesDaily(getUserId());
        // 查询库存
//        Long allInventoryQuantity = inventoryService.getAllInventoryQuantity();
        Long allInventoryQuantity = 0L;
        result.put("inventory",allInventoryQuantity.doubleValue());
        result.put("salesVolume",todaySalesDaily.getAmount()==null?0.00:todaySalesDaily.getAmount().doubleValue());
        result.put("orderCount",todaySalesDaily.getCount().doubleValue());
        result.put("shopCount",shopCount.doubleValue());

        return AjaxResult.success(result);
    }


    @GetMapping("/salesDaily")
    public AjaxResult salesDaily()
    {
        List<SalesDailyVo> salesDailyVos = orderService.salesDaily(getUserId());

        return AjaxResult.success(salesDailyVos);
    }

//    @GetMapping("/salesTopSku")
//    public AjaxResult salesTopSku()
//    {
//        List<SalesTopSkuVo> salesTopSkuVos = orderItemService.selectTopSku("2024-01-01", "2024-12-31");
//
//        return AjaxResult.success(salesTopSkuVos);
//    }
}
