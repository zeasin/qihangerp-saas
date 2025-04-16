package cn.qihangerp.api.domain;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 
 * @TableName erp_shop_goods_sku
 */
@Data
@TableName("erp_shop_goods_sku")
public class ShopGoodsSku implements Serializable {
    /**
     * 
     */
    private String id;

    /**
     * 外键id
     */
    private Long shopGoodsId;

    /**
     * 租户id
     */
    private Long tenantId;
    private Long shopId;

    /**
     * 平台商品id
     */
    private String productId;

    /**
     * skuID
     */
    private String skuId;

    /**
     * 商家自定义skuID。如果添加时没录入，回包可能不包含该字段
     */
    private String outSkuId;

    /**
     * sku小图
     */
    private String thumbImg;

    /**
     * 售卖价格，以分为单位
     */
    private Integer salePrice;

    /**
     * sku库存
     */
    private Integer stockNum;

    /**
     * sku编码
     */
    private String skuCode;

    /**
     * sku状态
     */
    private Integer status;

    /**
     * sku_attrs
     */
    private String skuAttrs;

    /**
     * sku_deliver_info
     */
    private String skuDeliverInfo;

    /**
     * erp系统商品id
     */
    private Long erpGoodsId;

    /**
     * erp系统商品skuid
     */
    private Long erpGoodsSkuId;


    private static final long serialVersionUID = 1L;
}