package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpGoods;
import cn.qihangerp.api.domain.ErpShopBill;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【erp_shop_bill(店铺账单)】的数据库操作Service
* @createDate 2025-05-26 11:05:47
*/
public interface ErpShopBillService extends IService<ErpShopBill> {
    PageResult<ErpShopBill> queryPageList(ErpShopBill bo, PageQuery pageQuery);
}
