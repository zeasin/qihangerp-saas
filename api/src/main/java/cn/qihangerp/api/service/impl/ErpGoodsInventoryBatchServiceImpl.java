package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.domain.ErpGoodsInventoryBatch;
import cn.qihangerp.api.mapper.ErpGoodsInventoryBatchMapper;
import cn.qihangerp.api.service.ErpGoodsInventoryBatchService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author qilip
* @description 针对表【o_goods_inventory_batch(商品库存批次)】的数据库操作Service实现
* @createDate 2025-02-16 08:26:56
*/
@AllArgsConstructor
@Service
public class ErpGoodsInventoryBatchServiceImpl extends ServiceImpl<ErpGoodsInventoryBatchMapper, ErpGoodsInventoryBatch>
    implements ErpGoodsInventoryBatchService {

    @Override
    public List<ErpGoodsInventoryBatch> querySkuBatchList(Long skuId) {
        LambdaQueryWrapper<ErpGoodsInventoryBatch> queryWrapper = new LambdaQueryWrapper<ErpGoodsInventoryBatch>();
        queryWrapper.eq(ErpGoodsInventoryBatch::getSkuId, skuId);

        return this.baseMapper.selectList(queryWrapper);
    }
}




