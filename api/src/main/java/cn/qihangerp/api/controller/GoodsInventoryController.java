package cn.qihangerp.api.controller;

import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.ErpGoodsInventory;
import cn.qihangerp.api.domain.ErpGoodsInventoryBatch;
import cn.qihangerp.api.request.GoodsSkuInventoryVo;
import cn.qihangerp.api.service.ErpGoodsInventoryBatchService;
import cn.qihangerp.api.service.ErpGoodsInventoryService;
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
    private final ErpGoodsInventoryService goodsInventoryService;
    private final ErpGoodsInventoryBatchService inventoryBatchService;

    @GetMapping("/list")
    public TableDataInfo list(ErpGoodsInventory bo, PageQuery pageQuery)
    {
        bo.setTenantId(getUserId());
        PageResult<ErpGoodsInventory> pageResult = goodsInventoryService.queryPageList(bo, pageQuery);
        return getDataTable(pageResult);
    }

    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        ErpGoodsInventory goodsInventory = goodsInventoryService.getById(id);
        if(goodsInventory!=null) {
            List<ErpGoodsInventoryBatch> list = inventoryBatchService.list(new LambdaQueryWrapper<ErpGoodsInventoryBatch>().eq(ErpGoodsInventoryBatch::getSkuId, goodsInventory.getSkuId()));
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

    /**
     * 查询skuid库存
     * @param skuId
     * @return
     */
    @GetMapping("/querySkuInventory")
    public AjaxResult querySkuInventory(Long skuId)
    {
        long inventory = goodsInventoryService.querySkuInventory(skuId);
        return AjaxResult.success(inventory);
    }
}
