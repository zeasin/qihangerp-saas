package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.BillShopAccounts;
import cn.qihangerp.api.domain.ErpLogisticsCompany;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【erp_bill_shop_accounts(店铺账目表)】的数据库操作Service
* @createDate 2025-05-28 15:02:57
*/
public interface BillShopAccountsService extends IService<BillShopAccounts> {
    PageResult<BillShopAccounts> queryPageList(BillShopAccounts bo, PageQuery pageQuery);
}
