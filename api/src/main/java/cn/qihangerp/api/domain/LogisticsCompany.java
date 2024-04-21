package cn.qihangerp.api.domain;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

/**
 * 平台快递公司表
 * @TableName sys_logistics_company
 */
@TableName("erp_logistics_company")
@Data
public class LogisticsCompany implements Serializable {
    /**
     * 主键ID
     */
    private String id;

    /**
     * 平台id
     */
    private String platformId;

    /**
     * 店铺ID
     */
    private String shopId;
    private Long tenantId;

    /**
     * 物流公司id（值来自于平台返回）
     */
    private Long logisticsId;


    /**
     * 物流公司编码（值来自于平台返回）
     */
    private String code;

    /**
     * 物流公司名称（值来自于平台返回）
     */
    private String name;

    /**
     * 备注
     */
    private String remark;
    private Integer status;

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    private static final long serialVersionUID = 1L;


}