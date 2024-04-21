package cn.qihangerp.api.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 * 采购订单
 * @TableName erp_purchase_order
 */
@Data
public class ErpPurchaseOrder implements Serializable {
    /**
     * 
     */
    private String id;

    /**
     * 租户id
     */
    private Long tenantId;

    /**
     * 供应商id
     */
    private String supplierId;

    /**
     * 订单编号
     */
    private String orderNo;

    /**
     * 订单日期
     */
    private Date orderDate;

    /**
     * 订单创建时间
     */
    private Long orderTime;

    /**
     * 订单总金额
     */
    private BigDecimal orderAmount;

    /**
     * 物流费用
     */
    private BigDecimal shipAmount;

    /**
     * 备注
     */
    private String remark;

    /**
     * 订单状态 0待审核1已审核101供应商已确认102供应商已发货2已收货3已入库
     */
    private Integer status;

    /**
     * 采购单审核人
     */
    private String auditUser;

    /**
     * 审核时间
     */
    private Long auditTime;

    /**
     * 供应商确认时间
     */
    private Date supplierConfirmTime;

    /**
     * 供应商发货时间
     */
    private Date supplierDeliveryTime;

    /**
     * 收货时间
     */
    private Date receivedTime;

    /**
     * 入库时间
     */
    private Date stockInTime;

    /**
     * 创建人
     */
    private String createBy;

    /**
     * 创建时间
     */
    private Date createTime;

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