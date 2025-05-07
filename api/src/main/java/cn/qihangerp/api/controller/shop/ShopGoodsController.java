package cn.qihangerp.api.controller.shop;

import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.ShopGoods;
import cn.qihangerp.api.request.PushShopGoodsToErp;
import cn.qihangerp.api.service.ShopGoodsService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@AllArgsConstructor
@RestController
@RequestMapping("/shop/goods")
public class ShopGoodsController extends BaseController {

    private final ShopGoodsService goodsService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public TableDataInfo goodsList(ShopGoods bo, PageQuery pageQuery) {
        if(getUserId()!=1) {
            bo.setTenantId(getUserId());
        }
        PageResult<ShopGoods> result = goodsService.queryPageList(bo, pageQuery);

        return getDataTable(result);
    }

    @PostMapping("/push_erp")
    @ResponseBody
    public AjaxResult pushErp(@RequestBody String[] ids) {
        if (ids == null || ids.length == 0) return AjaxResult.error("缺少参数");
        int success = 0;
        int isExist = 0;
        int fail = 0;
        for (String id : ids) {
            ResultVo resultVo = goodsService.pushToErp(Long.parseLong(id));
            if(resultVo.getCode()==0) success++;
            else if(resultVo.getCode()==ResultVoEnum.DataExist.getIndex()) isExist++;
            else fail++;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("success", success);
        map.put("isExist", isExist);
        map.put("fail", fail);
        map.put("total", success + isExist+fail);
        return success(map);
    }
}
