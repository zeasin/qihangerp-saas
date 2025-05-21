package cn.qihangerp.api.controller.shop;

import lombok.Data;

@Data
public class PddTokenCreateBo {
    private Long shopId;
    private Integer shopType;
    private String code;
}
