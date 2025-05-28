package cn.qihangerp.api.service;

import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.domain.ErpOrderShipWaybill;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【erp_order_ship_waybill(发货-电子面单记录表（打单记录）)】的数据库操作Service
* @createDate 2025-05-27 19:48:49
*/
public interface ErpOrderShipWaybillService extends IService<ErpOrderShipWaybill> {
    /**
     * 保存电子面单数据
     * @param orderNum
     * @param waybillCode
     * @param printData
     * @return
     */
    ResultVo saveWaybill(String orderNum,String waybillCode,String logisticsCode,String printData);
}
