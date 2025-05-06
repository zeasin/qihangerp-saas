package cn.qihangerp.api.controller;

import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.OGoodsInventory;
import cn.qihangerp.api.domain.OGoodsInventoryBatch;
import cn.qihangerp.api.request.GoodsSkuInventoryVo;
import cn.qihangerp.api.service.OGoodsInventoryBatchService;
import cn.qihangerp.api.service.OGoodsInventoryService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping("/goodsInventory")
public class GoodsInventoryController extends BaseController {
    private final OGoodsInventoryService goodsInventoryService;
    private final OGoodsInventoryBatchService inventoryBatchService;

    @GetMapping("/list")
    public TableDataInfo list(OGoodsInventory bo, PageQuery pageQuery)
    {
        PageResult<OGoodsInventory> pageResult = goodsInventoryService.queryPageList(bo, pageQuery);
        return getDataTable(pageResult);
    }

    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        OGoodsInventory goodsInventory = goodsInventoryService.getById(id);
        if(goodsInventory!=null) {
            List<OGoodsInventoryBatch> list = inventoryBatchService.list(new LambdaQueryWrapper<OGoodsInventoryBatch>().eq(OGoodsInventoryBatch::getSkuId, goodsInventory.getSkuId()));
            return AjaxResult.success(list);
        }
        return success();
    }

    /**
     * 搜索SKU库存
     * @param keyword
     * @return
     */
    @GetMapping("/searchSkuInventoryBatch")
    public TableDataInfo searchSkuInventoryBatch(String keyword)
    {
        List<GoodsSkuInventoryVo> list = goodsInventoryService.searchSkuInventoryBatch(keyword);
        return getDataTable(list);
    }
}
