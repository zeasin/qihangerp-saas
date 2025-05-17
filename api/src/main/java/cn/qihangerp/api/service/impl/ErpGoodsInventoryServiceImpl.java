package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpGoodsInventory;
import cn.qihangerp.api.mapper.ErpGoodsInventoryMapper;
import cn.qihangerp.api.request.GoodsSkuInventoryVo;
import cn.qihangerp.api.service.ErpGoodsInventoryService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

/**
* @author qilip
* @description 针对表【o_goods_inventory(商品库存表)】的数据库操作Service实现
* @createDate 2024-09-23 22:39:50
*/
@AllArgsConstructor
@Service
public class ErpGoodsInventoryServiceImpl extends ServiceImpl<ErpGoodsInventoryMapper, ErpGoodsInventory>
    implements ErpGoodsInventoryService {
    private final ErpGoodsInventoryMapper mapper;

    @Override
    public PageResult<ErpGoodsInventory> queryPageList(ErpGoodsInventory bo, PageQuery pageQuery) {

        LambdaQueryWrapper<ErpGoodsInventory> queryWrapper = new LambdaQueryWrapper<ErpGoodsInventory>();
        queryWrapper.eq(bo.getTenantId() != null, ErpGoodsInventory::getTenantId, bo.getTenantId());
        queryWrapper.eq(bo.getGoodsId()!=null, ErpGoodsInventory::getGoodsId,bo.getGoodsId());
        queryWrapper.eq(bo.getSkuId()!=null, ErpGoodsInventory::getSkuId,bo.getSkuId());
        queryWrapper.eq(StringUtils.hasText(bo.getGoodsNum()), ErpGoodsInventory::getGoodsNum,bo.getGoodsNum());
        queryWrapper.eq(StringUtils.hasText(bo.getSkuCode()), ErpGoodsInventory::getSkuCode,bo.getSkuCode());

        Page<ErpGoodsInventory> pages = mapper.selectPage(pageQuery.build(), queryWrapper);

        return PageResult.build(pages);
    }

    @Override
    public long getAllInventoryQuantity() {
        return mapper.getAllInventoryQuantity();
    }

    @Override
    public List<GoodsSkuInventoryVo> searchSkuInventoryBatch(String keyword) {
        return mapper.searchSkuInventoryBatch(keyword);
    }

    @Override
    public long querySkuInventory(Long skuId) {
        LambdaQueryWrapper<ErpGoodsInventory> queryWrapper = new LambdaQueryWrapper<ErpGoodsInventory>();
        queryWrapper.eq(ErpGoodsInventory::getSkuId,skuId);
        List<ErpGoodsInventory> oGoodsInventories = mapper.selectList(queryWrapper);
        if(oGoodsInventories==null||oGoodsInventories.isEmpty()){
            return 0;
        }else {
            return oGoodsInventories.get(0).getQuantity();
        }
    }
}




