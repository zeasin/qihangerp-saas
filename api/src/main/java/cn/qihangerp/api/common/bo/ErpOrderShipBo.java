package cn.qihangerp.api.common.bo;

import lombok.Data;

@Data
public class ErpOrderShipBo {
    private String Id;//订单id
    private float length;
    private float width;
    private float height;
    private float weight;
    private float volume;
    private float shippingCost;//物流费用
    private String shippingCompany;//发货公司
    private String shippingNumber;//发货单号
    private String shippingMan;//发货人
    private String remark;
}
