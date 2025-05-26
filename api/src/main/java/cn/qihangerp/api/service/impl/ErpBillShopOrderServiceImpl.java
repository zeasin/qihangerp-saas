package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ErpBillShopOrder;
import cn.qihangerp.api.service.ErpBillShopOrderService;
import cn.qihangerp.api.mapper.ErpBillShopOrderBillMapper;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
* @author qilip
* @description 针对表【erp_shop_bill(店铺账单)】的数据库操作Service实现
* @createDate 2025-05-26 11:05:47
*/
@Service
public class ErpBillShopOrderServiceImpl extends ServiceImpl<ErpBillShopOrderBillMapper, ErpBillShopOrder>
    implements ErpBillShopOrderService {

    @Override
    public PageResult<ErpBillShopOrder> queryPageList(ErpBillShopOrder bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpBillShopOrder> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(bo.getTenantId()!=null, ErpBillShopOrder::getTenantId,bo.getTenantId());
        queryWrapper.eq(bo.getShopId()!=null, ErpBillShopOrder::getShopId,bo.getShopId());
        queryWrapper.eq(StringUtils.hasText(bo.getOrderId()), ErpBillShopOrder::getOrderId,bo.getOrderId());
        Page<ErpBillShopOrder> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);
        return PageResult.build(pages);
    }
}




