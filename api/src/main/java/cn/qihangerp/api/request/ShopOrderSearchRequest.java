package cn.qihangerp.api.request;

import cn.qihangerp.api.domain.ShopOrderItem;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 
 * @TableName wei_order
 */

@Data
public class ShopOrderSearchRequest implements Serializable {

    private Long shopId;
    private Long tenantId;
    /**
     * 订单号
     */
    private String orderId;

    /**
     * 状态10	待付款；20	待发货；21	部分发货；30	待收货；100	完成；200	全部商品售后之后，订单取消；250	未付款用户主动取消或超时未付款订单自动取消；
     */
    private Integer status;
    private String startTime;
    private String endTime;

    private static final long serialVersionUID = 1L;
}