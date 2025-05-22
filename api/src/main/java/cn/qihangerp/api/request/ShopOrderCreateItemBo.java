package cn.qihangerp.api.request;

import lombok.Data;

import java.math.BigDecimal;
@Data
public class ShopOrderCreateItemBo {
    /** skuId */
    private String skuId;
    private String goodsId;

    /** skuCode */
    private String skuCode;
    private String goodsName;
    private String goodsNum;
    private String skuName;
    private String goodsImg;
    private BigDecimal goodsPrice;
    private BigDecimal itemAmount;
    private Integer quantity;
    private Integer isGift;
}
