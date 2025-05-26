package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpBillShopOrder;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ErpBillShipment;
import cn.qihangerp.api.service.ErpBillShipmentService;
import cn.qihangerp.api.mapper.ErpBillShipmentMapper;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
* @author qilip
* @description 针对表【erp_bill_shipment(账单-发货账单表)】的数据库操作Service实现
* @createDate 2025-05-26 12:07:59
*/
@Service
public class ErpBillShipmentServiceImpl extends ServiceImpl<ErpBillShipmentMapper, ErpBillShipment>
    implements ErpBillShipmentService{

    @Override
    public PageResult<ErpBillShipment> queryPageList(ErpBillShipment bo, PageQuery pageQuery) {

        LambdaQueryWrapper<ErpBillShipment> queryWrapper = new LambdaQueryWrapper<ErpBillShipment>();
        queryWrapper.eq(bo.getTenantId() != null, ErpBillShipment::getTenantId, bo.getTenantId());
        queryWrapper.eq(bo.getShopId() != null, ErpBillShipment::getShopId, bo.getShopId());
        queryWrapper.eq(StringUtils.hasText(bo.getOrderNum()), ErpBillShipment::getOrderNum, bo.getOrderNum());
        Page<ErpBillShipment> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);
        return PageResult.build(pages);

    }
}




