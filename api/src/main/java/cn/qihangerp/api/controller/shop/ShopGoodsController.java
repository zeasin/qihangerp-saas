package cn.qihangerp.api.controller.shop;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.TableDataInfo;
import cn.qihangerp.api.domain.WeiGoods;
import cn.qihangerp.api.domain.WeiOrder;
import cn.qihangerp.api.service.WeiGoodsService;
import cn.qihangerp.api.service.WeiOrderService;

@AllArgsConstructor
@RestController
@RequestMapping("/shop/goods")
public class ShopGoodsController extends BaseController {
    private final WeiGoodsService goodsService;
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public TableDataInfo goodsList(WeiGoods bo, PageQuery pageQuery) {
        PageResult<WeiGoods> result = goodsService.queryPageList(bo, pageQuery);

        return getDataTable(result);
    }
}
