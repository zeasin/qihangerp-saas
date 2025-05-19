package cn.qihangerp.api.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 后台任务运行日志表
 * @TableName erp_shop_task_logs
 */
@TableName(value ="erp_shop_task_logs")
@Data
public class ErpShopTaskLogs implements Serializable {
    /**
     * 主键ID
     */
    @TableId
    private Long id;

    /**
     * 任务ID
     */
    private Integer taskId;

    /**
     * 结果
     */
    private String result;

    /**
     * 开始运行时间
     */
    private Date startTime;

    /**
     * 结束时间
     */
    private Date endTime;

    /**
     * 状态1运行中，2已结束
     */
    private Integer status;

    /**
     * 创建时间
     */
    private Date createTime;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}