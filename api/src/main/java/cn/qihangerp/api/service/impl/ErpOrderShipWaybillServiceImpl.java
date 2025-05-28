package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.common.bo.ErpOrderShipBo;
import cn.qihangerp.api.domain.ErpOrder;
import cn.qihangerp.api.mapper.ErpOrderMapper;
import cn.qihangerp.api.service.ErpOrderService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ErpOrderShipWaybill;
import cn.qihangerp.api.service.ErpOrderShipWaybillService;
import cn.qihangerp.api.mapper.ErpOrderShipWaybillMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
* @author qilip
* @description 针对表【erp_order_ship_waybill(发货-电子面单记录表（打单记录）)】的数据库操作Service实现
* @createDate 2025-05-27 19:48:49
*/
@AllArgsConstructor
@Service
public class ErpOrderShipWaybillServiceImpl extends ServiceImpl<ErpOrderShipWaybillMapper, ErpOrderShipWaybill>
    implements ErpOrderShipWaybillService{

    private final ErpOrderService erpOrderService;

    @Transactional(rollbackFor = Exception.class)
    @Override
    public ResultVo saveWaybill(String orderNum, String waybillCode,String logisticsCode, String printData) {
        List<ErpOrder> list = erpOrderService.list(new LambdaQueryWrapper<ErpOrder>().eq(ErpOrder::getOrderNum, orderNum));
        if(list==null||list.size()==0){
            return ResultVo.error("没有找到订单数据");
        }
        ErpOrder erpOrder = list.get(0);
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

        // 手动发货
        ErpOrderShipBo shipBo = new ErpOrderShipBo();
        shipBo.setId(erpOrder.getId());
        shipBo.setLength(0.0);
        shipBo.setWidth(0.0);
        shipBo.setHeight(0.0);
        shipBo.setWeight(0.0);
        shipBo.setVolume(0.0);
        shipBo.setShippingCost(BigDecimal.valueOf(4));
        shipBo.setShippingCompany(logisticsCode);
        shipBo.setShippingNumber(waybillCode);
        shipBo.setShippingMan("取号发货");
        erpOrderService.manualShipmentOrder(shipBo,"");
        //更新订单数据
        ErpOrder updateOrder = new ErpOrder();
        updateOrder.setId(erpOrder.getId());
        updateOrder.setWaybillCode(waybillCode);
        updateOrder.setWaybillTime(new Date());
        updateOrder.setWaybillStatus(1);
        erpOrderService.updateById(updateOrder);


        return ResultVo.success();
    }
}




