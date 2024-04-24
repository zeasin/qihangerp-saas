package cn.qihangerp.api.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 * 财务管理-应付款-采购货款
 * @TableName erp_purchase_order_payable
 */
@Data
public class ErpPurchaseOrderPayable implements Serializable {
    /**
     * 
     */
    private Long id;

    /**
     * 供应商id
     */
    private String supplierId;
    private Long tenantId;

    /**
     * 供应商名称
     */
    private String supplierName;

    /**
     * 应付金额
     */
    private BigDecimal amount;

    /**
     * 应付日期
     */
    private Date date;

    /**
     * 发票号码
     */
    private String invoiceNo;

    /**
     * 采购单号
     */
    private String purchaseOrderNo;

    /**
     * 采购说明
     */
    private String purchaseDesc;

    /**
     * 备注
     */
    private String remark;

    /**
     * 状态（0已生成1已结算)
     */
    private Integer status;

    /**
     * 订单创建时间
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

    private static final long serialVersionUID = 1L;
}