package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.OGoodsInventory;
import cn.qihangerp.api.mapper.OGoodsInventoryMapper;
import cn.qihangerp.api.request.GoodsSkuInventoryVo;
import cn.qihangerp.api.service.OGoodsInventoryService;
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
public class OGoodsInventoryServiceImpl extends ServiceImpl<OGoodsInventoryMapper, OGoodsInventory>
    implements OGoodsInventoryService {
    private final OGoodsInventoryMapper mapper;

    @Override
    public PageResult<OGoodsInventory> queryPageList(OGoodsInventory bo, PageQuery pageQuery) {
        LambdaQueryWrapper<OGoodsInventory> queryWrapper = new LambdaQueryWrapper<OGoodsInventory>();
        queryWrapper.eq(bo.getGoodsId()!=null,OGoodsInventory::getGoodsId,bo.getGoodsId());
        queryWrapper.eq(bo.getSkuId()!=null,OGoodsInventory::getSkuId,bo.getSkuId());
        queryWrapper.eq(StringUtils.hasText(bo.getGoodsNum()),OGoodsInventory::getGoodsNum,bo.getGoodsNum());
        queryWrapper.eq(StringUtils.hasText(bo.getSkuCode()),OGoodsInventory::getSkuCode,bo.getSkuCode());

        Page<OGoodsInventory> pages = mapper.selectPage(pageQuery.build(), queryWrapper);

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
        LambdaQueryWrapper<OGoodsInventory> queryWrapper = new LambdaQueryWrapper<OGoodsInventory>();
        queryWrapper.eq(OGoodsInventory::getSkuId,skuId);
        List<OGoodsInventory> oGoodsInventories = mapper.selectList(queryWrapper);
        if(oGoodsInventories==null||oGoodsInventories.isEmpty()){
            return 0;
        }else {
            return oGoodsInventories.get(0).getQuantity();
        }
    }
}




