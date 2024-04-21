package cn.qihangerp.api.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 * 采购订单费用确认表
 * @TableName erp_purchase_order_cost
 */
@Data
public class ErpPurchaseOrderCost implements Serializable {
    /**
     * 采购单ID（主键）
     */
    private Long id;

    /**
     * 租户id
     */
    private Long tenantId;

    /**
     * 供应商id
     */
    private Long supplierId;

    /**
     * 采购单id
     */
    private Long orderId;

    /**
     * 采购单金额
     */
    private BigDecimal orderAmount;

    /**
     * 采购订单日期
     */
    private Date orderDate;

    /**
     * 采购订单编号
     */
    private String orderNo;

    /**
     * 采购订单商品规格数
     */
    private Integer orderSpecUnit;

    /**
     * 采购订单商品数
     */
    private Integer orderGoodsUnit;

    /**
     * 采购订单总件数
     */
    private Integer orderSpecUnitTotal;

    /**
     * 实际金额
     */
    private BigDecimal actualAmount;

    /**
     * 运费
     */
    private BigDecimal freight;

    /**
     * 确认人
     */
    private String confirmUser;

    /**
     * 确认时间
     */
    private Date confirmTime;

    /**
     * 创建人
     */
    private String createBy;

    /**
     * 已支付金额
     */
    private BigDecimal payAmount;

    /**
     * 支付时间
     */
    private Date payTime;

    /**
     * 支付次数
     */
    private Integer payCount;

    /**
     * 说明
     */
    private String remark;

    /**
     * 状态（0未支付1已支付）
     */
    private Integer status;

    /**
     * 更新人
     */
    private String updateBy;

    /**
     * 更新时间
     */
    private Date updateTime;

    private static final long serialVersionUID = 1L;
}