package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpOrderItem;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ErpShipmentItem;
import cn.qihangerp.api.service.ErpShipmentItemService;
import cn.qihangerp.api.mapper.ErpShipmentItemMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
* @author qihang
* @description 针对表【erp_shipment_item(发货明细表)】的数据库操作Service实现
* @createDate 2025-05-16 17:20:49
*/
@AllArgsConstructor
@Service
public class ErpShipmentItemServiceImpl extends ServiceImpl<ErpShipmentItemMapper, ErpShipmentItem>
    implements ErpShipmentItemService{

    @Override
    public PageResult<ErpShipmentItem> queryPageList(ErpShipmentItem bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpShipmentItem> queryWrapper = new LambdaQueryWrapper<ErpShipmentItem>()
                .eq(bo.getTenantId()!=null,ErpShipmentItem::getTenantId,bo.getTenantId())
                .eq(bo.getShipper()!=null,ErpShipmentItem::getShipper,bo.getShipper())
                .eq(bo.getStockStatus()!=null,ErpShipmentItem::getStockStatus,bo.getStockStatus())

                ;
        Page<ErpShipmentItem> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);

        return PageResult.build(pages);
    }
}




