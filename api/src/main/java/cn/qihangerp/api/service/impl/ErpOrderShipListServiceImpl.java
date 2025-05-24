package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpOrderShipListItem;
import cn.qihangerp.api.domain.ErpShipment;
import cn.qihangerp.api.domain.ErpShipmentItem;
import cn.qihangerp.api.mapper.ErpOrderShipListItemMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ErpOrderShipList;
import cn.qihangerp.api.service.ErpOrderShipListService;
import cn.qihangerp.api.mapper.ErpOrderShipListMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
* @author qilip
* @description 针对表【erp_order_ship_list(发货-备货表（取号发货加入备货清单、分配供应商发货加入备货清单）)】的数据库操作Service实现
* @createDate 2025-05-24 18:52:58
*/
@AllArgsConstructor
@Service
public class ErpOrderShipListServiceImpl extends ServiceImpl<ErpOrderShipListMapper, ErpOrderShipList>
    implements ErpOrderShipListService{
    private final ErpOrderShipListItemMapper shipListItemMapper;
    @Override
    public PageResult<ErpOrderShipList> queryPageList(ErpOrderShipList shipping, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpOrderShipList> queryWrapper = new LambdaQueryWrapper<ErpOrderShipList>()
                .eq(shipping.getShipper()!=null,ErpOrderShipList::getShipper,shipping.getShipper())
                .eq(ErpOrderShipList::getTenantId,shipping.getTenantId())
                .eq(StringUtils.hasText(shipping.getOrderNum()), ErpOrderShipList::getOrderNum, shipping.getOrderNum())
                .eq(StringUtils.hasText(shipping.getShipLogisticsCode()), ErpOrderShipList::getShipLogisticsCode, shipping.getShipLogisticsCode())
                .eq(shipping.getShopId() != null, ErpOrderShipList::getShopId, shipping.getShopId());

        Page<ErpOrderShipList> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);
        if(pages.getRecords().size()>0){
            for(ErpOrderShipList item : pages.getRecords()){
                item.setItems(shipListItemMapper.selectList(new LambdaQueryWrapper<ErpOrderShipListItem>().eq(ErpOrderShipListItem::getListId,item.getId())));
            }
        }
        return PageResult.build(pages);
    }

    @Override
    public ErpOrderShipList queryDetailById(Long id) {
        ErpOrderShipList erpOrderShipList = this.baseMapper.selectById(id);
        if(erpOrderShipList==null){
            return null;
        }
        erpOrderShipList.setItems(shipListItemMapper.selectList(new LambdaQueryWrapper<ErpOrderShipListItem>().eq(ErpOrderShipListItem::getListId,erpOrderShipList.getId())));
        return erpOrderShipList;
    }
}




