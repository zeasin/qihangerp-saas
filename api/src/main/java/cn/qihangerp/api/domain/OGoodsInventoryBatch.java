package cn.qihangerp.api.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 商品库存批次
 * @TableName o_goods_inventory_batch
 */
@TableName(value ="erp_goods_inventory_batch")
@Data
public class OGoodsInventoryBatch implements Serializable {
    /**
     * 主键ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long inventoryId;

    /**
     * 批次号
     */
    private String batchNum;

    /**
     * 初始数量
     */
    private Integer originQty;

    /**
     * 当前数量
     */
    private Integer currentQty;

    /**
     * 采购价
     */
    private Double purPrice;

    /**
     * 采购单id
     */
    private Long purId;

    /**
     * 采购单itemId
     */
    private Long purItemId;

    /**
     * 备注
     */
    private String remark;

    /**
     * 规格id
     */
    private String skuId;

    /**
     * 商品id
     */
    private String goodsId;

    /**
     * sku编码
     */
    private String skuCode;

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
    private static final long serialVersionUID = 1L;
}