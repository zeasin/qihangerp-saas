package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.domain.ErpOrder;
import cn.qihangerp.api.mapper.ErpOrderMapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ErpOrderShipWaybill;
import cn.qihangerp.api.service.ErpOrderShipWaybillService;
import cn.qihangerp.api.mapper.ErpOrderShipWaybillMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
* @author qilip
* @description 针对表【erp_order_ship_waybill(发货-电子面单记录表（打单记录）)】的数据库操作Service实现
* @createDate 2025-05-27 19:48:49
*/
@AllArgsConstructor
@Service
public class ErpOrderShipWaybillServiceImpl extends ServiceImpl<ErpOrderShipWaybillMapper, ErpOrderShipWaybill>
    implements ErpOrderShipWaybillService{
    private final ErpOrderMapper erpOrderMapper;

    @Transactional(rollbackFor = Exception.class)
    @Override
    public ResultVo saveWaybill( String orderId, String waybillCode,String logisticsCode, String printData) {
        ErpOrder erpOrder = erpOrderMapper.selectById(orderId);
        if(erpOrder==null){
            return ResultVo.error("没有找到订单数据");
        }
        // 添加取单单号
        ErpOrderShipWaybill waybill = new ErpOrderShipWaybill();
        waybill.setTentantId(erpOrder.getTenantId());
        waybill.setShopId(erpOrder.getShopId());
        waybill.setShopType(erpOrder.getShopType());
        waybill.setOrderNum(erpOrder.getOrderNum());
        waybill.setErpOrderId(Long.parseLong(erpOrder.getId()));
        waybill.setLogisticsCode(logisticsCode);
        waybill.setWaybillCode(waybillCode);
        waybill.setPrintData(printData);
        waybill.setStatus(1);
        waybill.setCreateTime(new Date());
        this.baseMapper.insert(waybill);

        //更新订单数据
        ErpOrder updateOrder = new ErpOrder();
        updateOrder.setId(erpOrder.getId());
        updateOrder.setWaybillCode(waybillCode);
        updateOrder.setWaybillTime(new Date());
        updateOrder.setWaybillStatus(1);
        erpOrderMapper.updateById(updateOrder);

        return ResultVo.success();
    }
}




