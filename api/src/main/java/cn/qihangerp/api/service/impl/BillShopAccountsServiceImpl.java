package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpLogisticsCompany;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.BillShopAccounts;
import cn.qihangerp.api.service.BillShopAccountsService;
import cn.qihangerp.api.mapper.BillShopAccountsMapper;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
* @author qilip
* @description 针对表【erp_bill_shop_accounts(店铺账目表)】的数据库操作Service实现
* @createDate 2025-05-28 15:02:57
*/
@Service
public class BillShopAccountsServiceImpl extends ServiceImpl<BillShopAccountsMapper, BillShopAccounts>
    implements BillShopAccountsService{

    @Override
    public PageResult<BillShopAccounts> queryPageList(BillShopAccounts bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BillShopAccounts> queryWrapper = new LambdaQueryWrapper<BillShopAccounts>()
                .eq(BillShopAccounts::getTenantId,bo.getTenantId())
                .like(StringUtils.hasText(bo.getDate()),BillShopAccounts::getDate,bo.getDate())
                .eq(bo.getShopId() != null, BillShopAccounts::getShopId, bo.getShopId())
                .eq(bo.getType() != null, BillShopAccounts::getType, bo.getType());

        Page<BillShopAccounts> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);
        return PageResult.build(pages);
    }
}




