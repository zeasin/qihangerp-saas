package cn.qihangerp.api.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 出库仓位详情
 * @TableName wms_stock_out_item_position
 */
@TableName(value ="wms_stock_out_item_position")
@Data
public class ErpStockOutItemPosition implements Serializable {
    /**
     * 主键ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 出库单ID
     */
    private Long outId;

    /**
     * 出库单ItemID
     */
    private Long itemId;

    /**
     * 库存ID
     */
    private Long goodsInventoryId;

    /**
     * 库存详情ID
     */
    private Long goodsInventoryBatchId;

    /**
     * 出库数量
     */
    private Integer quantity;

    /**
     * 出库操作人userid
     */
    private Long operatorId;

    /**
     * 出库操作人
     */
    private String operatorName;

    /**
     * 出库时间
     */
    private Date outTime;

    /**
     * 租户 id
     */
    private Long tenantId;

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

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}