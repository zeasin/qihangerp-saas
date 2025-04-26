package cn.qihangerp.api.request;

import lombok.Data;

import java.util.List;

/**
 * 订单对象 erp_order
 *
 * @author qihang
 * @date 2024-01-05
 */
@Data
public class ShopOrderCreateBo
{
    private static final long serialVersionUID = 1L;


    /** 订单编号 */
    private String orderId;

    /** 店铺ID */
    private Long shopId;
    private Long tenantId;

    /** 买家留言信息 */
    private String buyerMemo;

    /** 备注 */
    private String remark;

    // 下单时间
    private String orderTime;
    // 订单状态
    private Integer status;


    /** 商品金额 */
    private Double goodsAmount;
    private Double orderAmount;

    /** 卖家优惠金额 */
    private Double sellerDiscount;

    /** 平台优惠金额 */
    private Double platformDiscount;

    /** 运费 */
    private Double postage;


    /** 收件人姓名 */
    private String receiverName;

    /** 收件人手机号 */
    private String receiverPhone;

    /** 收件人地址 */
    private String address;


    /** 省 */
    private String province;

    /** 市 */
    private String city;

    /** 区 */
    private String county;


    /** 订单明细信息 */
    private List<ShopOrderCreateItemBo> itemList;

}
