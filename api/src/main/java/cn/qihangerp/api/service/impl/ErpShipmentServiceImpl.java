package cn.qihangerp.api.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.util.StringUtils;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpShipment;
import cn.qihangerp.api.mapper.ErpOrderItemMapper;
import cn.qihangerp.api.mapper.ErpOrderMapper;
import cn.qihangerp.api.service.ErpShipmentService;
import cn.qihangerp.api.mapper.ErpShipmentMapper;
import org.springframework.stereotype.Service;

/**
* @author TW
* @description 针对表【erp_order_shipping(发货记录表)】的数据库操作Service实现
* @createDate 2024-04-03 15:57:41
*/
@AllArgsConstructor
@Service
public class ErpShipmentServiceImpl extends ServiceImpl<ErpShipmentMapper, ErpShipment>
    implements ErpShipmentService {
    private final ErpShipmentMapper mapper;
    private final ErpOrderMapper orderMapper;
    private final ErpOrderItemMapper itemMapper;

    @Override
    public PageResult<ErpShipment> queryPageList(ErpShipment shipping, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpShipment> queryWrapper = new LambdaQueryWrapper<ErpShipment>()
                .eq(StringUtils.hasText(shipping.getOrderNum()), ErpShipment::getOrderNum, shipping.getOrderNum())
                .eq(StringUtils.hasText(shipping.getShipCode()), ErpShipment::getShipCode, shipping.getShipCode())
                .eq(shipping.getShopId() != null, ErpShipment::getShopId, shipping.getShopId());

        Page<ErpShipment> pages = mapper.selectPage(pageQuery.build(), queryWrapper);
        return PageResult.build(pages);
    }

//    @Transactional
//    @Override
//    public ResultVo<Integer> handShip(ErpOrderShipping shipping) {
//        // 查询店铺订单是否存在
//        List<ErpOrder> oOrders = orderMapper.selectList(new LambdaQueryWrapper<ErpOrder>().eq(ErpOrder::getOrderNum, shipping.getOrderNum()).eq(ErpOrder::getShopId, shipping.getShopId()));
//        if(oOrders== null || oOrders.isEmpty()) {
//            // 没有找到订单
//            return ResultVo.error(ResultVoEnum.NotFound,shipping.getOrderNum()+"订单未找到");
//        }
//        // 查询订单ITEM
//        List<ErpOrderItem> oOrderItems = itemMapper.selectList(new LambdaQueryWrapper<ErpOrderItem>().eq(ErpOrderItem::getOrderId, oOrders.get(0).getId()));
//        shipping.setShipTime(new Date());
//        shipping.setPackages(JSONObject.toJSONString(oOrderItems));
//        shipping.setOrderId(oOrders.get(0).getId());
//        shipping.setRemark("手动发货");
//        shipping.setCreateTime(new Date());
//        mapper.insert(shipping);
//        // 回写状态
//        ErpOrder update = new ErpOrder();
//        update.setId(oOrders.get(0).getId());
//        update.setOrderStatus(2);//2已发货
//        update.setShippingTime(new Date());
//        update.setShippingCompany(shipping.getShipCompany());
//        update.setShippingNumber(shipping.getShipCode());
//        update.setShippingMan(shipping.getShipOperator());
//        update.setUpdateTime(new Date());
//        update.setUpdateBy("手动发货");
//        orderMapper.updateById(update);
//
//        return ResultVo.success();
//    }
}




