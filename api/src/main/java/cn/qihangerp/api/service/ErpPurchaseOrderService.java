package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpOrder;
import cn.qihangerp.api.domain.ErpPurchaseOrder;
import cn.qihangerp.api.domain.bo.PurchaseOrderAddBo;
import cn.qihangerp.api.domain.bo.PurchaseOrderOptionBo;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【erp_purchase_order(采购订单)】的数据库操作Service
* @createDate 2024-04-21 20:27:10
*/
public interface ErpPurchaseOrderService extends IService<ErpPurchaseOrder> {
    PageResult<ErpPurchaseOrder> queryPageList(ErpPurchaseOrder bo, PageQuery pageQuery);

    int insertScmPurchaseOrder(PurchaseOrderAddBo addBo);

    int updateScmPurchaseOrder(PurchaseOrderOptionBo scmPurchaseOrder);
}
