package cn.qihangerp.api.request;

import lombok.Data;

@Data
public class ShopDailyRequest {
    private Long regionId;
    private Long platformId;
    private Long shopId;
    private Long shopGroupId;
    private Long manageUserId;
    private String skuCode;
    private String[] dates;
}
