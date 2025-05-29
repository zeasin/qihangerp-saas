package cn.qihangerp.api.request;

import cn.qihangerp.api.domain.ErpOrderItem;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 订单表
 * @TableName erp_order
 */
@Data
public class OrderSearchRequest implements Serializable {
    /**
     * 订单id
     */
    private String id;


    /**
     * 订单编号（第三方平台订单号）
     */
    private String orderNum;

    /**
     * 店铺类型
     */
    private Integer shopType;

    /**
     * 店铺ID
     */
    private Long shopId;
    private Long tenantId;
    /**
     * 售后状态 1：无售后或售后关闭，2：售后处理中，3：退款中，4： 退款成功 
     */
    private Integer refundStatus;

    /**
     * 订单状态1：待发货，2：已发货，3：已完成
     */
    private Integer orderStatus;

    /**
     * 收件人姓名
     */
    private String receiverName;

    /**
     * 收件人手机号
     */
    private String receiverMobile;

    /**
     * 省
     */
    private String province;

    /**
     * 市
     */
    private String city;

    /**
     * 区
     */
    private String town;

    /**
     * 订单时间
     */
    private Date orderTime;

    /**
     * 发货方式1电子面单发货2手动发货
     */
    private Integer shipType;
    /**
     * 发货方式 0 自己发货1联合发货2供应商发货
     */
    private Integer shipper;


    /**
     * 是否推送到ERP
     */
    private Integer hasPushErp;

    private String startTime;
    private String endTime;

    private static final long serialVersionUID = 1L;
}