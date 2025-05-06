package cn.qihangerp.api.mapper;

import cn.qihangerp.api.domain.OGoodsInventory;
import cn.qihangerp.api.request.GoodsSkuInventoryVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* @author qilip
* @description 针对表【o_goods_inventory(商品库存表)】的数据库操作Mapper
* @createDate 2024-09-23 22:39:50
* @Entity cn.qihangerp.module.goods.domain.OGoodsInventory
*/
public interface OGoodsInventoryMapper extends BaseMapper<OGoodsInventory> {
    long getAllInventoryQuantity();
    List<GoodsSkuInventoryVo> searchSkuInventoryBatch(String keyword);
}




