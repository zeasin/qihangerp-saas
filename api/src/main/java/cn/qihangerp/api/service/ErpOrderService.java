package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.common.bo.ErpOrderShipBo;
import cn.qihangerp.api.domain.ErpOrder;
import cn.qihangerp.api.domain.vo.SalesDailyVo;
import cn.qihangerp.api.request.OrderSearchRequest;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author TW
* @description 针对表【erp_order(订单表)】的数据库操作Service
* @createDate 2024-04-03 15:57:41
*/
public interface ErpOrderService extends IService<ErpOrder> {
    PageResult<ErpOrder> queryPageList(OrderSearchRequest bo, PageQuery pageQuery);

    ResultVo<Integer> shipErpOrder(ErpOrderShipBo shipBo);

    List<SalesDailyVo> salesDaily(Long tenantId);
    SalesDailyVo getTodaySalesDaily(Long tenantId);
}
