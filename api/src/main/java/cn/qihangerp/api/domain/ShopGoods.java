package cn.qihangerp.api.domain;

import java.io.Serializable;
import java.util.List;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 
 * @TableName erp_shop_goods
 */
@Data
@TableName("erp_shop_goods")
public class ShopGoods implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private String id;

    /**
     * 店铺id
     */
    private Long shopId;

    /**
     * 租户id
     */
    private Long tenantId;

    /**
     * 平台商品id
     */
    private String productId;

    /**
     * 商家编码id
     */
    private String outProductId;

    /**
     * 商品标题
     */
    private String title;

    /**
     * 
     */
    private String subTitle;

    /**
     * 主图集合
     */
    private String headImgs;

    /**
     * 第一张主图
     */
    private String headImg;

    /**
     * 商品详情字符串
     */
    private String descInfo;

    /**
     * 属性字符串
     */
    private String attrs;

    /**
     * 状态
     */
    private Integer status;

    /**
     * 编辑状态
     */
    private Integer editStatus;

    /**
     * 商品 SKU 最小价格（单位：分）
     */
    private Integer minPrice;

    /**
     * 商品编码
     */
    private String spuCode;

    /**
     * 商品类型。1: 小店普通自营商品；2: 福袋抽奖商品；3: 直播间闪电购商品。注意: 福袋抽奖、直播间闪电购类型的商品为只读数据，不支持编辑、上架操作，不支持用data_type=2的参数获取。
     */
    private Integer productType;

    /**
     * 商品草稿最近一次修改时间
     */
    private String editTime;
    private Long erpGoodsId;

    @TableField(exist = false)
    private List<ShopGoodsSku> skus;

    private static final long serialVersionUID = 1L;
}