package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpGoods;
import cn.qihangerp.api.domain.ErpGoodsSku;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ErpShopBill;
import cn.qihangerp.api.service.ErpShopBillService;
import cn.qihangerp.api.mapper.ErpShopBillMapper;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
* @author qilip
* @description 针对表【erp_shop_bill(店铺账单)】的数据库操作Service实现
* @createDate 2025-05-26 11:05:47
*/
@Service
public class ErpShopBillServiceImpl extends ServiceImpl<ErpShopBillMapper, ErpShopBill>
    implements ErpShopBillService{

    @Override
    public PageResult<ErpShopBill> queryPageList(ErpShopBill bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpShopBill> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(bo.getTenantId()!=null,ErpShopBill::getTenantId,bo.getTenantId());
        queryWrapper.eq(bo.getShopId()!=null,ErpShopBill::getShopId,bo.getShopId());
        queryWrapper.eq(StringUtils.hasText(bo.getOrderId()),ErpShopBill::getOrderId,bo.getOrderId());
        Page<ErpShopBill> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);
        return PageResult.build(pages);
    }
}




