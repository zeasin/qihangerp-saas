package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpBillShopOrder;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【erp_shop_bill(店铺账单)】的数据库操作Service
* @createDate 2025-05-26 11:05:47
*/
public interface ErpBillShopOrderService extends IService<ErpBillShopOrder> {
    PageResult<ErpBillShopOrder> queryPageList(ErpBillShopOrder bo, PageQuery pageQuery);
}
