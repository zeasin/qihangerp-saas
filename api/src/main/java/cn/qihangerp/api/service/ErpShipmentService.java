package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.domain.ErpShipment;
import cn.qihangerp.api.request.SupplierAgentShipmentRequest;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author TW
* @description 针对表【erp_order_shipping(发货记录表)】的数据库操作Service
* @createDate 2024-04-03 15:57:41
*/
public interface ErpShipmentService extends IService<ErpShipment> {
    PageResult<ErpShipment> queryPageList(ErpShipment shipping, PageQuery pageQuery);
    ErpShipment queryDetailById(Long id);
    ResultVo<Integer> handShip(SupplierAgentShipmentRequest shipping);
}
