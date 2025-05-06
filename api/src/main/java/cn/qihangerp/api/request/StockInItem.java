package cn.qihangerp.api.request;

import lombok.Data;

@Data
public class StockInItem {
    private Long id;
    private Integer intoQuantity;
    private Long positionId;
    private String positionNum;
}
