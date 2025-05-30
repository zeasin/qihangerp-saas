package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpBillShipment;
import cn.qihangerp.api.domain.ErpBillShopOrder;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【erp_bill_shipment(账单-发货账单表)】的数据库操作Service
* @createDate 2025-05-26 12:07:59
*/
public interface ErpBillShipmentService extends IService<ErpBillShipment> {
    /**
     * 供应商发货账单
     * @param bo
     * @param pageQuery
     * @return
     */
    PageResult<ErpBillShipment> querySupplierPageList(ErpBillShipment bo, PageQuery pageQuery);
    PageResult<ErpBillShipment> queryWarehousePageList(ErpBillShipment bo, PageQuery pageQuery);
}
