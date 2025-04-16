package cn.qihangerp.api.controller.shop;

import lombok.Data;

@Data
public class PullRequest {
    private Long shopId;//店铺Id
    private Long orderId;//订单编号
    private Integer pullType;
}
