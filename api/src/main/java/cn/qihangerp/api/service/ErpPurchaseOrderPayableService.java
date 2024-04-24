package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpPurchaseOrder;
import cn.qihangerp.api.domain.ErpPurchaseOrderPayable;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【erp_purchase_order_payable(财务管理-应付款-采购货款)】的数据库操作Service
* @createDate 2024-04-24 20:21:59
*/
public interface ErpPurchaseOrderPayableService extends IService<ErpPurchaseOrderPayable> {
    PageResult<ErpPurchaseOrderPayable> queryPageList(ErpPurchaseOrderPayable bo, PageQuery pageQuery);
}
