package cn.qihangerp.api.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 仓库库存操作记录表
 * @TableName erp_goods_inventory_operation
 */
@TableName(value ="erp_goods_inventory_operation")
@Data
public class ErpGoodsInventoryOperation implements Serializable {
    /**
     * 主键ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 商品id
     */
    private Long goodsId;

    /**
     * 商品编码
     */
    private String goodsNum;

    /**
     * 商品规格id
     */
    private Long skuId;

    /**
     * 规格编码（唯一）
     */
    private String skuCode;

    /**
     * 库存批次id
     */
    private Long batchId;

    /**
     * 库存批次号
     */
    private String batchNum;

    /**
     * 库存类型（1增加库存2减少库存3锁定库存）
     */
    private Integer type;

    /**
     * 商品库存id（本表id减库存的时候关联）
     */
    private Long inventoryId;

    /**
     * 操作库存数量
     */
    private Integer quantity;

    /**
     * 锁定库存数量（status变成已结算时把该字段值更新到quantity）
     */
    private Integer lockedQuantity;

    /**
     * 价格（type=1采购价格；type=2出库时的价格）
     */
    private Double price;

    /**
     * 业务类型（10采购入库20采购退货出库30销售退货入库40订单发货出库50订单补发出库99其他出库）
     */
    private Integer bizType;

    /**
     * 业务单id
     */
    private Long bizId;

    /**
     * 业务单号
     */
    private String bizNum;

    /**
     * 业务单itemId
     */
    private Long bizItemId;

    /**
     * 状态（0待结算1已结算）
     */
    private Integer status;

    /**
     * 备注
     */
    private String remark;

    /**
     * 仓库id
     */
    private Long warehouseId;

    /**
     * 仓位id
     */
    private Long positionId;

    /**
     * 仓位
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

    /**
     * 租户 id
     */
    private Long tenantId;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}