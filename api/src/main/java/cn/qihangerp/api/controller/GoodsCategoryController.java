package cn.qihangerp.api.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.TableDataInfo;
import cn.qihangerp.api.domain.ErpGoods;
import cn.qihangerp.api.domain.ErpGoodsCategory;
import cn.qihangerp.api.domain.ErpGoodsCategoryAttributeValue;
import cn.qihangerp.api.service.ErpGoodsCategoryAttributeValueService;
import cn.qihangerp.api.service.ErpGoodsCategoryService;
import cn.qihangerp.api.service.ErpGoodsService;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping("/goods/category")
public class GoodsCategoryController extends BaseController {
    private final ErpGoodsCategoryService categoryService;
    private final ErpGoodsCategoryAttributeValueService attributeValueService;


    @GetMapping("/list")
    public TableDataInfo list()
    {
        List<ErpGoodsCategory> list = categoryService.list();
        return getDataTable(list);
    }

    @GetMapping("/attr_value/{id}")
    public TableDataInfo attrValueList(@PathVariable("id") Integer id)
    {
        var list = attributeValueService.list(
                new LambdaQueryWrapper<ErpGoodsCategoryAttributeValue>()
                        .eq(ErpGoodsCategoryAttributeValue::getCategoryAttributeId,id)
        );

        return getDataTable(list);
    }
}
