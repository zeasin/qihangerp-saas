package cn.qihangerp.api.domain.vo;


import lombok.Data;

import java.math.BigDecimal;

@Data
public class GoodsSpecListVo {

    private Long id;
    private Long goodsId;

    /** 商品名称 */
    private String name;

    /** 商品编号 */
    private String number;
    private String specNum;
    private String colorValue;
    /** 商品图片地址 */
    private String colorImage;
    private String sizeValue;
    private String styleValue;
    private BigDecimal purPrice;

}
