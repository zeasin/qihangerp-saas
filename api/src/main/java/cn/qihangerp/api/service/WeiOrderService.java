package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.domain.WeiOrder;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【wei_order】的数据库操作Service
* @createDate 2024-04-03 21:36:32
*/
public interface WeiOrderService extends IService<WeiOrder> {
    PageResult<WeiOrder> queryPageList(WeiOrder bo, PageQuery pageQuery);
    ResultVo<Integer> saveOrder(Long shopId, WeiOrder order);
    ResultVo<Integer> orderConfirm(String[] ids);
}
