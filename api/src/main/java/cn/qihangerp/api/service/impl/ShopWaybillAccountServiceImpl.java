package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.domain.ShopRefund;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ShopWaybillAccount;
import cn.qihangerp.api.service.ShopWaybillAccountService;
import cn.qihangerp.api.mapper.ShopWaybillAccountMapper;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
* @author qilip
* @description 针对表【erp_shop_waybill_account(店铺电子面单账户信息表)】的数据库操作Service实现
* @createDate 2025-05-27 14:00:58
*/
@Service
public class ShopWaybillAccountServiceImpl extends ServiceImpl<ShopWaybillAccountMapper, ShopWaybillAccount>
    implements ShopWaybillAccountService{

    @Override
    public PageResult<ShopWaybillAccount> queryPageList(ShopWaybillAccount bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ShopWaybillAccount> queryWrapper = new LambdaQueryWrapper<ShopWaybillAccount>()
                .eq(ShopWaybillAccount::getTenantId, bo.getTenantId())
                .eq(bo.getShopType()!=null,ShopWaybillAccount::getShopType, bo.getShopType())
                .eq(bo.getShopId()!=null, ShopWaybillAccount::getShopId,bo.getShopId())
                .like(StringUtils.hasText(bo.getName()), ShopWaybillAccount::getName,bo.getName())
                ;

        Page<ShopWaybillAccount> taoGoodsPage = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);

        return PageResult.build(taoGoodsPage);
    }

    @Override
    public ResultVo<Integer> syncAccountList(Long shopId, List<ShopWaybillAccount> accountList) {
        if(shopId==null) return ResultVo.error("缺少参数ShopId");
        if(accountList.isEmpty()) return ResultVo.error("没有数据");

        List<ShopWaybillAccount> list = this.baseMapper.selectList(
                new LambdaQueryWrapper<ShopWaybillAccount>()
                        .eq(ShopWaybillAccount::getShopId, shopId));
        List<Long> accIds = new ArrayList<>();
        for(ShopWaybillAccount acc:accountList) {
            List<ShopWaybillAccount> collect = list.stream().filter(x -> x.getAcctId().equals(acc.getAcctId())).collect(Collectors.toList());
            if(collect.isEmpty()){
                // 没有找到 新增
                this.baseMapper.insert(acc);
                accIds.add(acc.getId());
            }else {
                // 存在更新
                acc.setId(collect.get(0).getId());
                this.baseMapper.updateById(acc);
                accIds.add(acc.getId());
            }
        }
        // 删除已经不存在的数据
        this.baseMapper.delete(new LambdaQueryWrapper<ShopWaybillAccount>().notIn(ShopWaybillAccount::getId,accIds));
        return ResultVo.success();
    }
}




