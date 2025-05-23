package cn.qihangerp.api.service;

import cn.qihangerp.api.domain.ErpGoodsInventoryBatch;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author qilip
* @description 针对表【o_goods_inventory_batch(商品库存批次)】的数据库操作Service
* @createDate 2025-02-16 08:26:56
*/
public interface ErpGoodsInventoryBatchService extends IService<ErpGoodsInventoryBatch> {
    List<ErpGoodsInventoryBatch> querySkuBatchList(Long skuId);
}
