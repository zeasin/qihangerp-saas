package cn.qihangerp.api.request;

import lombok.Data;

@Data
public class StockOutItemRequest {
    private Long entryItemId;
    private Long entryId;
    private String skuId;
    private String positionId;
    private Integer outQty;
    private Integer originalQuantity;
    private Integer outQuantity;

}
