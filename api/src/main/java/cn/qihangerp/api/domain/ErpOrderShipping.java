package cn.qihangerp.api.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

/**
 * 发货记录表
 * @TableName erp_order_shipping
 */
@Data
public class ErpOrderShipping implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 店铺id
     */
    private Long shopId;
    private int shopType;

    /**
     * o_order表id
     */
    private String orderId;

    /**
     * 订单编号
     */
    private String orderNum;

    /**
     * 发货类型（1订单发货2商品补发3商品换货）
     */
    private Integer shipType;

    /**
     * 物流公司
     */
    private String shipCompany;
    private String shipCompanyCode;

    /**
     * 物流单号
     */
    private String shipCode;

    /**
     * 物流费用
     */
    private Float shipFee;

    /**
     * 发货时间
     */
    private Date shipTime;

    /**
     * 发货操作人
     */
    private String shipOperator;

    /**
     * 物流状态（1运输中2已完成）
     */
    private Integer shipStatus;

    /**
     * 包裹重量
     */
    private Float packageWeight;

    /**
     * 包裹长度
     */
    private Float packageLength;

    /**
     * 包裹宽度
     */
    private Float packageWidth;

    /**
     * 包裹高度
     */
    private Float packageHeight;

    /**
     * 打包操作人
     */
    private String packsgeOperator;

    /**
     * 打包时间
     */
    private Date packsgeTime;

    /**
     * 包裹内容JSON
     */
    private String packages;

    /**
     * 备注
     */
    private String remark;

    /**
     * 
     */
    private Date createTime;

    /**
     * 
     */
    private String createBy;

    /**
     * 
     */
    private Date updateTime;

    /**
     * 
     */
    private Date updateBy;

    private static final long serialVersionUID = 1L;
}