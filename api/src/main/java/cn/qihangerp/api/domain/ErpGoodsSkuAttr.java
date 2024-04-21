package cn.qihangerp.api.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * 
 * @TableName erp_goods_sku_attr
 */
@Data
public class ErpGoodsSkuAttr implements Serializable {
    /**
     * 
     */
    private String id;

    /**
     * 
     */
    private String goodsId;

    /**
     * 
     */
    private String type;

    /**
     * 
     */
    private String k;

    /**
     * 
     */
    private String kid;

    /**
     * 
     */
    private String vid;

    /**
     * 
     */
    private String v;

    /**
     * 
     */
    private String img;

    private static final long serialVersionUID = 1L;
}