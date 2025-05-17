package cn.qihangerp.api.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 商品库存表
 * @TableName o_goods_inventory
 */
@TableName(value ="erp_goods_inventory")
@Data
public class ErpGoodsInventory implements Serializable {
    /**
     * 主键ID
     */
    @TableId(type = IdType.AUTO)
    private String id;

    private Long tenantId;

    /**
     * 商品id
     */
    private String goodsId;

    /**
     * 商品编码
     */
    private String goodsNum;

    /**
     * 商品规格id
     */
    private String skuId;

    /**
     * 规格编码（唯一）
     */
    private String skuCode;

    /**
     * 商品名
     */
    private String goodsName;

    /**
     * 商品图片
     */
    private String goodsImg;

    /**
     * SKU名
     */
    private String skuName;

    /**
     * 当前库存
     */
    private Integer quantity;
    //s 锁定库存
    private Integer lockedQty;

    /**
     * 0正常  1删除
     */
    private Integer isDelete;

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