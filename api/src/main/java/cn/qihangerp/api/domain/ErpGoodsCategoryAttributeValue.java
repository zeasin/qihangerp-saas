package cn.qihangerp.api.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * 
 * @TableName erp_goods_category_attribute_value
 */
@Data
public class ErpGoodsCategoryAttributeValue implements Serializable {
    /**
     * 主键，属性值id
     */
    private String id;

    /**
     * 属性id
     */
    private String categoryAttributeId;

    /**
     * 属性值文本
     */
    private String value;

    /**
     * 生成SKU的编码
     */
    private String skuCode;

    /**
     * 
     */
    private Integer orderNum;

    /**
     * 
     */
    private Integer isDelete;

    private static final long serialVersionUID = 1L;
}