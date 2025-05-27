package cn.qihangerp.api.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 发货-电子面单记录表（打单记录）
 * @TableName erp_order_ship_waybill
 */
@TableName(value ="erp_order_ship_waybill")
@Data
public class ErpOrderShipWaybill implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 租户id
     */
    private Long tentantId;

    /**
     * 店铺id
     */
    private Long shopId;

    /**
     * 店铺类型
     */
    private Integer shopType;

    /**
     * 订单号
     */
    private String orderNum;

    /**
     * 发货订单ID
     */
    private Long erpOrderId;

    /**
     * 电子面单订单id(仅视频号)
     */
    private String waybillOrderId;

    /**
     * 快递单号
     */
    private String waybillCode;

    /**
     * 快递公司编码
     */
    private String logisticsCode;

    /**
     * 打印数据
     */
    private String printData;

    /**
     * 打印加密数据（抖音）
     */
    private String sign;

    /**
     * 状态（1已取号2已打印3已发货）
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

    /**
     * 打印模版url
     */
    private String templateUrl;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}