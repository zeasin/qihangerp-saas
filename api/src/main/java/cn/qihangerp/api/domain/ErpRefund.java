package cn.qihangerp.api.domain;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 退换货表
 * @TableName erp_refund
 */
@Data
public class ErpRefund implements Serializable {
    /**
     * 
     */
    private Long id;

    /**
     * 退货单号
     */
    private String refundNum;

    /**
     * 类型(10-退货 20-换货 30-维修 40-大家电安装 50-大家电移机 60-大家电增值服务 70-上门维修 90-优鲜赔 80-补发商品 100-试用收回 11-仅退款)
     */
    private Integer refundType;

    /**
     * 店铺id
     */
    private Integer shopId;

    /**
     * 店铺类型
     */
    private Integer shopType;

    /**
     * 退款金额
     */
    private Double refundFee;

    /**
     * 退款原因
     */
    private String refundReason;

    /**
     * 源订单号
     */
    private String orderNum;

    /**
     * 子订单号或id
     */
    private String orderItemNum;

    /**
     * 源skuId
     */
    private Long skuId;

    /**
     * erp商品id
     */
    private Long erpGoodsId;

    /**
     * erp sku id
     */
    private Long erpSkuId;

    /**
     * sku编码
     */
    private String skuNum;

    /**
     * 商品名称
     */
    private String goodsName;

    /**
     * 商品sku
     */
    private String goodsSku;

    /**
     * 商品图片
     */
    private String goodsImage;

    /**
     * 退货数量
     */
    private Long quantity;

    /**
     * 退货物流公司
     */
    private String returnLogisticsCompany;

    /**
     * 退货物流单号
     */
    private String returnLogisticsCode;

    /**
     * 收货时间
     */
    private Date receiveTime;

    /**
     * 备注
     */
    private String remark;

    /**
     * 发货人
     */
    private String contactperson;

    /**
     * 发货人手机号
     */
    private String mobile;

    /**
     * 发货地址
     */
    private String address;

    /**
     * 状态（10001待审核10002等待买家退货10005等待卖家收货14000拒绝退款10011退款关闭10010退款完成）
     */
    private Integer status;

    /**
     * 订单创建时间
     */
    private Date createTime;

    /**
     * 创建人
     */
    private String createBy;

    /**
     * 更新时间
     */
    private Date updateTime;

    /**
     * 更新人
     */
    private String updateBy;

    private static final long serialVersionUID = 1L;
}