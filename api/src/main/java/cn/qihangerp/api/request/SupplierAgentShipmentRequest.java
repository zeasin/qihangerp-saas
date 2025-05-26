package cn.qihangerp.api.request;




import java.math.BigDecimal;
import java.util.Date;

public record SupplierAgentShipmentRequest(Long id, BigDecimal goodsAmount, Long shipCompanyId, String shipNo, BigDecimal shipCost,
                                           String shipTime,String remark) {

}
