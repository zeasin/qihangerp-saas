package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.domain.WeiOrder;
import cn.qihangerp.api.domain.WeiRefund;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【wei_refund(视频号小店退款)】的数据库操作Service
* @createDate 2024-04-04 23:11:44
*/
public interface WeiRefundService extends IService<WeiRefund> {
    PageResult<WeiRefund> queryPageList(WeiRefund bo, PageQuery pageQuery);
    ResultVo<Integer> saveRefund(Integer shopId, WeiRefund refund);
    ResultVo<Integer> returnedConfirm( Long id);
    ResultVo<Integer> orderIntercept( Long id);
}
