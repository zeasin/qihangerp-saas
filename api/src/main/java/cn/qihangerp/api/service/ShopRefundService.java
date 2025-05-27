package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.domain.ShopRefund;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【wei_refund(视频号小店退款)】的数据库操作Service
* @createDate 2024-04-04 23:11:44
*/
public interface ShopRefundService extends IService<ShopRefund> {
    PageResult<ShopRefund> queryPageList(ShopRefund bo, PageQuery pageQuery);
    ResultVo<Integer> saveRefund(Long shopId, ShopRefund refund);
    ResultVo<Integer> returnedConfirm( Long id);
    ResultVo<Integer> orderIntercept( Long id);
    ShopRefund getRefundBy(String afterSaleOrderId);
}
