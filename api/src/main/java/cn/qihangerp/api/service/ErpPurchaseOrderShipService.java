package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpPurchaseOrder;
import cn.qihangerp.api.domain.ErpPurchaseOrderShip;
import cn.qihangerp.api.domain.bo.PurchaseOrderStockInBo;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【erp_purchase_order_ship(采购订单物流表)】的数据库操作Service
* @createDate 2024-04-21 20:27:10
*/
public interface ErpPurchaseOrderShipService extends IService<ErpPurchaseOrderShip> {
    PageResult<ErpPurchaseOrderShip> queryPageList(ErpPurchaseOrderShip bo, PageQuery pageQuery);


    int confirmPurchaseOrderShip(ErpPurchaseOrderShip bo);

    int createStockInEntry(PurchaseOrderStockInBo bo);
}
