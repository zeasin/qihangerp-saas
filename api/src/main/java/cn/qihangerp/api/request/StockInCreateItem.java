package cn.qihangerp.api.request;

import lombok.Data;

@Data
public class StockInCreateItem {
    private String skuId;
    private String goodsId;
    private Integer quantity;
    private String skuCode;
    private String goodsName;
    private String goodsImg;
    private String skuName;
    private Double purPrice;
}
