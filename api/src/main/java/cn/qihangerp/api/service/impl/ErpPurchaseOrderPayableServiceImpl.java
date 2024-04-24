package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpPurchaseOrder;
import cn.qihangerp.api.mapper.ErpPurchaseOrderMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ErpPurchaseOrderPayable;
import cn.qihangerp.api.service.ErpPurchaseOrderPayableService;
import cn.qihangerp.api.mapper.ErpPurchaseOrderPayableMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/**
* @author qilip
* @description 针对表【erp_purchase_order_payable(财务管理-应付款-采购货款)】的数据库操作Service实现
* @createDate 2024-04-24 20:21:59
*/
@AllArgsConstructor
@Service
public class ErpPurchaseOrderPayableServiceImpl extends ServiceImpl<ErpPurchaseOrderPayableMapper, ErpPurchaseOrderPayable>
    implements ErpPurchaseOrderPayableService{
    private final ErpPurchaseOrderPayableMapper mapper;

    @Override
    public PageResult<ErpPurchaseOrderPayable> queryPageList(ErpPurchaseOrderPayable bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpPurchaseOrderPayable> queryWrapper = new LambdaQueryWrapper<ErpPurchaseOrderPayable>()
//                .eq(ErpPurchaseOrder::getTenantId,bo.getTenantId())
//                .eq(bo.getSupplierId()!=null,ErpPurchaseOrder::getSupplierId,bo.getSupplierId())
//                .eq(org.springframework.util.StringUtils.hasText(bo.getOrderNo()),ErpPurchaseOrder::getOrderNo,bo.getOrderNo())
//                .eq(org.springframework.util.StringUtils.hasText(bo.getReceiverName()),ErpOrder::getReceiverName,bo.getReceiverName())
//                .like(org.springframework.util.StringUtils.hasText(bo.getReceiverMobile()),ErpOrder::getReceiverMobile,bo.getReceiverMobile())
                ;
        Page<ErpPurchaseOrderPayable> pages = mapper.selectPage(pageQuery.build(), queryWrapper);

        return PageResult.build(pages);
    }
}




