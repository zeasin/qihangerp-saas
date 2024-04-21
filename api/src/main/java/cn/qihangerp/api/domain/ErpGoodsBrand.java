package cn.qihangerp.api.domain;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 
 * @TableName erp_goods_brand
 */
@Data
public class ErpGoodsBrand implements Serializable {
    /**
     * 主键ID
     */
    private String id;

    /**
     * 品牌名
     */
    private String name;

    /**
     * 状态
     */
    private Integer status;

    /**
     * 租户id（sys_user_id）
     */
    private Long tenantId;

    /**
     * 
     */
    private String createBy;

    /**
     * 
     */
    private Date createTime;

    /**
     * 
     */
    private String updateBy;

    /**
     * 
     */
    private Date updateTime;

    private static final long serialVersionUID = 1L;
}