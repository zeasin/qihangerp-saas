package cn.qihangerp.api.domain.bo;

import java.util.List;
import cn.qihangerp.api.domain.BaseEntity;

/**
 * 采购订单对象 scm_purchase_order
 * 
 * @author qihang
 * @date 2023-12-29
 */
public class PurchaseOrderStockInBo
{
    private static final long serialVersionUID = 1L;

    private Long id;//物流id
    private Long orderId;//采购单id
    /** 创建者 */
    private String createBy;

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    private List<PurchaseOrderStockInItemBo> goodsList;

    public List<PurchaseOrderStockInItemBo> getGoodsList() {
        return goodsList;
    }

    public void setGoodsList(List<PurchaseOrderStockInItemBo> goodsList) {
        this.goodsList = goodsList;
    }

}
