package cn.qihangerp.api.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Data;

/**
 * 发货-备货表（取号发货加入备货清单、分配供应商发货加入备货清单）
 * @TableName erp_order_ship_list
 */
@TableName(value ="erp_order_ship_list")
@Data
public class ErpOrderShipList implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Long id;

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
     * 发货方 0 仓库发货 1 供应商发货
     */
    private Integer shipper;

    /**
     * 发货供应商ID（0自己发货）
     */
    private Long shipSupplierId;

    /**
     * 发货供应商
     */
    private String shipSupplier;

    /**
     * erp订单id
     */
    private Long orderId;

    /**
     * 订单编号
     */
    private String orderNum;

    /**
     * 物流公司
     */
    private String shipLogisticsCompany;

    /**
     * 物流公司code
     */
    private String shipLogisticsCompanyCode;

    /**
     * 物流单号
     */
    private String shipLogisticsCode;

    /**
     * 发货状态1：待发货，2：已发货，3已推送
     */
    private Integer shipStatus;

    /**
     * 状态0待备货1备货中2备货完成3已发货
     */
    private Integer status;

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
    private List<ErpOrderShipListItem> items;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}