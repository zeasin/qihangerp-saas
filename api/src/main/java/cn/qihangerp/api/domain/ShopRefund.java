package cn.qihangerp.api.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;
import lombok.Data;

/**
 * 视频号小店退款
 * @TableName erp_shop_refund
 */
@TableName(value ="erp_shop_refund")
@Data
public class ShopRefund implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private String id;

    /**
     * 租户id
     */
    private Long tenantId;

    /**
     * 店铺id
     */
    private Long shopId;

    /**
     * 店铺类型
     */
    private Integer shopType;

    /**
     * 售后单号
     */
    private String afterSaleOrderId;

    /**
     * 售后单当前状态，参考：AfterSaleStatus
     */
    private String status;

    /**
     * 买家身份标识
     */
    private String openid;

    /**
     * 买家在开放平台的唯一标识符，若当前视频号小店已绑定到微信开放平台账号下会返回
     */
    private String unionid;

    /**
     * 订单号，该字段可用于获取订单
     */
    private String orderId;

    /**
     * 订单金额
     */
    private Double orderAmount;

    /**
     * 商品spuid
     */
    private String productId;

    /**
     * 商品名称
     */
    private String goodsName;

    /**
     * 商品图片
     */
    private String goodsImage;

    /**
     * 商品skuid
     */
    private String skuId;

    /**
     * 售后数量
     */
    private Integer count;

    /**
     * 是否极速退款RefundInfo
     */
    private String fastRefund;

    /**
     * 标明售后单退款直接原因, 枚举值参考 RefundReason
     */
    private Integer refundReason;

    /**
     * 退款金额（分）
     */
    private Integer refundAmount;

    /**
     * 快递单号
     */
    private String returnWaybillId;

    /**
     * 物流公司id
     */
    private String returnDeliveryId;

    /**
     * 物流公司名称
     */
    private String returnDeliveryName;

    /**
     * 售后相关商品信息JSON
     */
    private String merchantUploadInfo;

    /**
     * 售后单创建时间戳
     */
    private Integer createTime;

    /**
     * 售后单更新时间戳
     */
    private Integer updateTime;

    /**
     * 退款原因
     */
    private String reason;

    /**
     * 退款原因解释
     */
    private String reasonText;

    /**
     * 售后类型。REFUND:退款；RETURN:退货退款。
     */
    private String type;

    /**
     * detail json
     */
    private String details;

    /**
     * 纠纷id，该字段可用于获取纠纷信息
     */
    private String complaintId;

    /**
     * 微信支付退款的响应
     */
    private String refundResp;

    /**
     * 确认状态9退货已签收8已拦截
     */
    private Integer confirmStatus;

    /**
     * 确认时间
     */
    private LocalDateTime confirmTime;

    /**
     * 用户发货状态
     */
    private Integer userShippingStatus;

    /**
     * 售后状态（参考拼多多）
     */
    private Integer afterSalesStatus;

    /**
     * 售后类型（参考拼多多）
     */
    private Integer afterSalesType;

    /**
     * 1纠纷退款 0非纠纷退款
     */
    private Integer disputeRefundStatus;

    /**
     * 系统创建时间
     */
    private Date createOn;

    /**
     * 系统更新时间
     */
    private Date updateOn;

    private Integer shippingStatus;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}