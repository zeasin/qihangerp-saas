package cn.qihangerp.api.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import lombok.Data;

/**
 * 店铺消息处理
 * @TableName erp_shop_message
 */
@TableName(value ="erp_shop_message")
@Data
public class ShopMessage implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 
     */
    private Long tenantId;

    /**
     * 3pdd5wei
     */
    private Integer shopType;

    /**
     * 事件类型
     */
    private String eventType;

    /**
     * 事件内容
     */
    private String eventContent;

    /**
     * 卖家ID
     */
    private String sellerId;

    /**
     * 处理状态0未处理1已处理
     */
    private Integer status;

    /**
     * 创建时间戳
     */
    private Long createTime;

    /**
     * 更新时间
     */
    private Long updateTime;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}