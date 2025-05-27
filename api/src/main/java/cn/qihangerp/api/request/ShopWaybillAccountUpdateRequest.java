package cn.qihangerp.api.request;

import lombok.Data;

@Data
public class ShopWaybillAccountUpdateRequest {
    private Long id;//电子面单Id
    private String siteName;
    private String siteCode;
    private String sellerShopId;
    private String name;
    private String mobile;
}
