package cn.qihangerp.api.request;

import lombok.Data;

@Data
public class StockShipmentStockOutRequest {
    private String stockOutNum;
    private Long[] ids;//发货item id
}
