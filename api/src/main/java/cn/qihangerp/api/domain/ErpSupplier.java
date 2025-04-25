package cn.qihangerp.api.domain;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

/**
 * 
 * @TableName erp_supplier
 */
@Data
public class ErpSupplier implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private String id;

    /**
     * 租户id
     */
    private Long tenantId;

    /**
     * 供应商名称
     */
    private String name;

    /**
     * 供应商编码
     */
    private String number;

    /**
     * 税率
     */
    private Double taxRate;

    /**
     * 期初应付款
     */
    private Double amount;

    /**
     * 期初预付款
     */
    private Double periodMoney;

    /**
     * 初期往来余额
     */
    private Double difMoney;

    /**
     * 余额日期
     */
    private Date beginDate;

    /**
     * 备注
     */
    private String remark;

    /**
     * 职位
     */
    private String place;

    /**
     * 联系人
     */
    private String contactMan;

    /**
     * 联系方式
     */
    private String contact;

    /**
     * 省
     */
    private String province;

    /**
     * 市
     */
    private String city;

    /**
     * 区县
     */
    private String county;

    /**
     * 收货地址详情
     */
    private String address;

    /**
     * 
     */
    private String pinyin;

    /**
     * 1启用   0禁用
     */
    private Integer disable;

    /**
     * 0正常 1删除
     */
    private Integer isDelete;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 
     */
    private String createBy;

    /**
     * 
     */
    private Date updateTime;

    /**
     * 
     */
    private String updateBy;

    private static final long serialVersionUID = 1L;
}