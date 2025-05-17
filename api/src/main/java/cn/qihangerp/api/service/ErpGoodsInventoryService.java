package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpGoodsInventory;
import cn.qihangerp.api.request.GoodsSkuInventoryVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author qilip
* @description 针对表【o_goods_inventory(商品库存表)】的数据库操作Service
* @createDate 2024-09-23 22:39:50
*/
public interface ErpGoodsInventoryService extends IService<ErpGoodsInventory> {
    PageResult<ErpGoodsInventory> queryPageList(ErpGoodsInventory bo, PageQuery pageQuery);
    long getAllInventoryQuantity();

    List<GoodsSkuInventoryVo> searchSkuInventoryBatch(String keyword);

    /**
     *  查看SKUID库存
     * @param skuId
     * @return
     */
    long querySkuInventory(Long skuId);
}
