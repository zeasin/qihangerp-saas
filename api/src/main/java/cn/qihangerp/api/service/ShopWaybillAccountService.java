package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.domain.ShopRefund;
import cn.qihangerp.api.domain.ShopWaybillAccount;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author qilip
* @description 针对表【erp_shop_waybill_account(店铺电子面单账户信息表)】的数据库操作Service
* @createDate 2025-05-27 14:00:58
*/
public interface ShopWaybillAccountService extends IService<ShopWaybillAccount> {
    PageResult<ShopWaybillAccount> queryPageList(ShopWaybillAccount bo, PageQuery pageQuery);
    ResultVo<Integer> syncAccountList(Long shopId, List<ShopWaybillAccount> accountList);
}
