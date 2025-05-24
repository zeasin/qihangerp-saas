package cn.qihangerp.api.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 入库单明细
 * @TableName wms_stock_in_item
 */
@TableName(value ="wms_stock_in_item")
@Data
public class ErpStockInItem implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 入库单id
     */
    private Long stockInId;
    private Long tenantId;

    /**
     * 来源类型（1采购订单2退货订单）
     */
    private Integer stockInType;

    /**
     * 来源单号
     */
    private String sourceNo;

    /**
     * 来源单id
     */
    private Long sourceId;

    /**
     * 来源单itemId
     */
    private Long sourceItemId;

    /**
     * 商品id
     */
    private Long goodsId;

    /**
     * 商品编码
     */
    private String goodsNum;

    /**
     * 商品名称
     */
    private String goodsName;

    /**
     * 商品图片
     */
    private String goodsImage;

    /**
     * 商品规格id
     */
    private Long skuId;

    /**
     * 商品规格编码
     */
    private String skuCode;

    /**
     * 颜色
     */
    private String skuName;

    /**
     * 原始数量
     */
    private Integer quantity;

    /**
     * 入库价格
     */
    private Double purPrice;

    /**
     * 入库数量
     */
    private Integer inQuantity;

    /**
     * 备注
     */
    private String remark;

    /**
     * 状态（0待入库2已入库）
     */
    private Integer status;

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

    /**
     * 仓库id
     */
    private Long warehouseId;

    /**
     * 仓位id
     */
    private Long positionId;

    /**
     * 仓位编码
     */
    private String positionNum;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}