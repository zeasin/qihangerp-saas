package cn.qihangerp.api.mapper;

import cn.qihangerp.api.domain.ErpOrder;
import cn.qihangerp.api.domain.vo.SalesDailyVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* @author TW
* @description 针对表【erp_order(订单表)】的数据库操作Mapper
* @createDate 2024-04-03 15:57:41
* @Entity cn.qihangerp.api.domain.ErpOrder
*/
public interface ErpOrderMapper extends BaseMapper<ErpOrder> {
    List<SalesDailyVo> salesDaily(Long tenantId);
    SalesDailyVo getTodaySalesDaily(Long tenantId);
}




