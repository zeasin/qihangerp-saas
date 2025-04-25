package cn.qihangerp.api.domain;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
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
    @TableId(type = IdType.AUTO)
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