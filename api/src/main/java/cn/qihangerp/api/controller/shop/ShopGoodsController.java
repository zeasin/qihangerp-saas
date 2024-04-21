package cn.qihangerp.api.controller.shop;

import cn.qihangerp.api.domain.ShopGoods;
import cn.qihangerp.api.service.ShopGoodsService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.TableDataInfo;

@AllArgsConstructor
@RestController
@RequestMapping("/shop/goods")
public class ShopGoodsController extends BaseController {

    private final ShopGoodsService goodsService;
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public TableDataInfo goodsList(ShopGoods bo, PageQuery pageQuery) {
        bo.setTenantId(getUserId());
        PageResult<ShopGoods> result = goodsService.queryPageList(bo, pageQuery);

        return getDataTable(result);
    }
}
