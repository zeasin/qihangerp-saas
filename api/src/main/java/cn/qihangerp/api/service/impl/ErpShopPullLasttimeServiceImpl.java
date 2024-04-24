package cn.qihangerp.api.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ErpShopPullLasttime;
import cn.qihangerp.api.service.ErpShopPullLasttimeService;
import cn.qihangerp.api.mapper.ErpShopPullLasttimeMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author qilip
* @description 针对表【erp_shop_pull_lasttime(店铺更新最后时间记录)】的数据库操作Service实现
* @createDate 2024-04-24 22:01:37
*/
@AllArgsConstructor
@Service
public class ErpShopPullLasttimeServiceImpl extends ServiceImpl<ErpShopPullLasttimeMapper, ErpShopPullLasttime>
    implements ErpShopPullLasttimeService{
    private final ErpShopPullLasttimeMapper mapper;
    @Override
    public ErpShopPullLasttime getLasttimeByShop(Long tenanId,Long shopId, String pullType) {
        List<ErpShopPullLasttime> sysShopPullLasttimes = mapper.selectList(
                new LambdaQueryWrapper<ErpShopPullLasttime>()
                        .eq(ErpShopPullLasttime::getTenantId,tenanId)
                        .eq(ErpShopPullLasttime::getShopId, shopId)
                        .eq(ErpShopPullLasttime::getPullType, pullType)
        );
        if(sysShopPullLasttimes != null && !sysShopPullLasttimes.isEmpty()) return sysShopPullLasttimes.get(0);
        else return null;
    }
}




