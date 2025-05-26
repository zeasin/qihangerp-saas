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
 * @TableName wms_stock_in_item_position
 */
@TableName(value ="erp_stock_in_item_position")
@Data
public class ErpStockInItemPosition implements Serializable {
    /**
     * 主键ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 入库单ID
     */
    private Long inId;

    /**
     * 入库单ItemID
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
     * 入库数量
     */
    private Integer quantity;

    /**
     * 入库操作人userid
     */
    private Long operatorId;

    /**
     * 入库操作人
     */
    private String operatorName;

    /**
     * 入库时间
     */
    private Date createTime;

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
     * 租户 id
     */
    private Long tenantId;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}