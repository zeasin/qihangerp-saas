package cn.qihangerp.api.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

/**
 * 订单表
 * @TableName erp_order
 */
@Data
public class ErpOrder implements Serializable {
    /**
     * 订单id，自增
     */
    @TableId(type = IdType.AUTO)
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
     * 订单备注
     */
    private String remark;

    /**
     * 买家留言信息
     */
    private String buyerMemo;

    /**
     * 卖家留言信息
     */
    private String sellerMemo;

    /**
     * 标签
     */
    private String tag;

    /**
     * 售后状态 1：无售后或售后关闭，2：售后处理中，3：退款中，4： 退款成功 
     */
    private Integer refundStatus;

    /**
     * 订单状态1：待发货，2：已发货，3：已完成
     */
    private Integer orderStatus;

    /**
     * 订单商品金额
     */
    private Double goodsAmount;

    /**
     * 订单实际金额
     */
    private Double amount;

    /**
     * 收件人姓名
     */
    private String receiverName;

    /**
     * 收件人手机号
     */
    private String receiverMobile;

    /**
     * 收件人地址
     */
    private String address;

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
     * 发货类型（0仓库发货；1供应商代发）
     */
    private Integer shipType;

    /**
     * 发货时间
     */
    private Date shippingTime;

    /**
     * 快递单号
     */
    private String shippingNumber;

    /**
     * 物流公司
     */
    private String shippingCompany;

    /**
     * 发货人
     */
    private String shippingMan;

    /**
     * 发货费用
     */
    private BigDecimal shippingCost;

    /**
     * 是否推送到ERP
     */
    private Integer hasPushErp;

    /**
     * 长
     */
    private Float length;

    /**
     * 宽
     */
    private Float width;

    /**
     * 高
     */
    private Float height;

    /**
     * 重量
     */
    private Float weight;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 创建人
     */
    private String createBy;

    /**
     * 更新时间
     */
    private Date updateTime;

    /**
     * 更新人
     */
    private String updateBy;
    @TableField(exist = false)
    private List<ErpOrderItem> itemList;

    private static final long serialVersionUID = 1L;
}