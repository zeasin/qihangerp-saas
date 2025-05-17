package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.domain.ErpShipment;
import cn.qihangerp.api.domain.ErpShipmentItem;
import cn.qihangerp.api.request.StockShipmentStockOutRequest;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qihang
* @description 针对表【erp_shipment_item(发货明细表)】的数据库操作Service
* @createDate 2025-05-16 17:20:49
*/
public interface ErpShipmentItemService extends IService<ErpShipmentItem> {
    PageResult<ErpShipmentItem> queryPageList(ErpShipmentItem shipping, PageQuery pageQuery);

    /**
     * 出库确认--仓库发货出库确认
     * @param request
     * @param createBy
     * @param userId
     * @return
     */
    ResultVo stockOutConfirm(StockShipmentStockOutRequest request,String createBy,Long userId);
}
