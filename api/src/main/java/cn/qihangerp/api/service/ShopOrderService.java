package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.domain.ShopOrder;
import cn.qihangerp.api.request.ShopOrderSearchRequest;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【wei_order】的数据库操作Service
* @createDate 2024-04-03 21:36:32
*/
public interface ShopOrderService extends IService<ShopOrder> {
    PageResult<ShopOrder> queryPageList(ShopOrderSearchRequest bo, PageQuery pageQuery);
    ResultVo<Long> saveOrder(Long shopId, ShopOrder order);
    ResultVo<Integer> orderConfirm(String[] ids);
}
