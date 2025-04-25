package cn.qihangerp.api.domain;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

/**
 * 更新日志表
 * @TableName erp_shop_pull_logs
 */
@Data
public class ErpShopPullLogs implements Serializable {
    /**
     * 主键Id
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 店铺id
     */
    private Long shopId;

    /**
     * 租户id
     */
    private Long tenantId;

    /**
     * 平台id
     */
    private Integer shopType;

    /**
     * 类型（ORDER订单，GOODS商品，REFUND退款）
     */
    private String pullType;

    /**
     * 拉取方式（主动拉取、定时任务）
     */
    private String pullWay;

    /**
     * 拉取参数
     */
    private String pullParams;

    /**
     * 拉取结果
     */
    private String pullResult;

    /**
     * 拉取时间
     */
    private Date pullTime;

    /**
     * 耗时（毫秒）
     */
    private Long duration;

    private static final long serialVersionUID = 1L;
}