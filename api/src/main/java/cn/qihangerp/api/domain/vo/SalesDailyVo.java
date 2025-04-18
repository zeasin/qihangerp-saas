package cn.qihangerp.api.domain.vo;

import lombok.Data;

@Data
public class SalesDailyVo {
    private String date;
    private Integer count;
    private Double amount;
}
