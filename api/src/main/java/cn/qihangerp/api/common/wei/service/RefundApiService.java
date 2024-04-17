package cn.qihangerp.api.common.wei.service;


import com.alibaba.fastjson2.JSONObject;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.service.annotation.HttpExchange;
import org.springframework.web.service.annotation.PostExchange;
import cn.qihangerp.api.common.wei.bo.OrderDetailBo;
import cn.qihangerp.api.common.wei.bo.OrderListBo;
import cn.qihangerp.api.common.wei.bo.RefundDetailBo;
import cn.qihangerp.api.common.wei.bo.RefundListBo;
import cn.qihangerp.api.common.wei.vo.OrderDetailVo;
import cn.qihangerp.api.common.wei.vo.OrderListVo;
import cn.qihangerp.api.common.wei.vo.RefundDetailVo;
import cn.qihangerp.api.common.wei.vo.RefundListVo;

@HttpExchange
public interface RefundApiService {
    @PostExchange("/channels/ec/aftersale/getaftersalelist")
    RefundListVo getRefundList(@RequestParam String access_token, @RequestBody RefundListBo bo);
    @PostExchange("/channels/ec/aftersale/getaftersaleorder")
    RefundDetailVo getRefundDetail(@RequestParam String access_token, @RequestBody RefundDetailBo bo);
}
