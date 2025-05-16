package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.domain.ErpLogisticsCompany;
import cn.qihangerp.api.domain.ErpShipment;
import cn.qihangerp.api.domain.vo.SalesDailyVo;
import cn.qihangerp.api.mapper.ErpShipmentMapper;
import cn.qihangerp.api.mapper.ErpLogisticsCompanyMapper;
import cn.qihangerp.api.request.OrderSearchRequest;
import com.alibaba.fastjson2.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.transaction.annotation.Transactional;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.common.ResultVoEnum;
import cn.qihangerp.api.common.bo.ErpOrderShipBo;
import cn.qihangerp.api.domain.ErpOrder;
import cn.qihangerp.api.domain.ErpOrderItem;
import cn.qihangerp.api.mapper.ErpOrderItemMapper;
import cn.qihangerp.api.service.ErpOrderService;
import cn.qihangerp.api.mapper.ErpOrderMapper;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
* @author TW
* @description 针对表【erp_order(订单表)】的数据库操作Service实现
* @createDate 2024-04-03 15:57:41
*/
@AllArgsConstructor
@Service
public class ErpOrderServiceImpl extends ServiceImpl<ErpOrderMapper, ErpOrder>
    implements ErpOrderService{
    private final ErpOrderMapper mapper;
    private final ErpOrderItemMapper orderItemMapper;
    private final ErpShipmentMapper orderShippingMapper;
    private final ErpLogisticsCompanyMapper erpLogisticsCompanyMapper;

    private final String DATE_PATTERN =
            "^(?:(?:(?:\\d{4}-(?:0?[1-9]|1[0-2])-(?:0?[1-9]|1\\d|2[0-8]))|(?:(?:(?:\\d{2}(?:0[48]|[2468][048]|[13579][26])|(?:(?:0[48]|[2468][048]|[13579][26])00))-0?2-29))$)|(?:(?:(?:\\d{4}-(?:0?[13578]|1[02]))-(?:0?[1-9]|[12]\\d|30))$)|(?:(?:(?:\\d{4}-0?[13-9]|1[0-2])-(?:0?[1-9]|[1-2]\\d|30))$)|(?:(?:(?:\\d{2}(?:0[48]|[13579][26]|[2468][048])|(?:(?:0[48]|[13579][26]|[2468][048])00))-0?2-29))$)$";
    private final Pattern DATE_FORMAT = Pattern.compile(DATE_PATTERN);


    @Override
    public PageResult<ErpOrder> queryPageList(OrderSearchRequest bo, PageQuery pageQuery) {
        if(org.springframework.util.StringUtils.hasText(bo.getStartTime())){
            Matcher matcher = DATE_FORMAT.matcher(bo.getStartTime());
            boolean b = matcher.find();
            if(b){
                bo.setStartTime(bo.getStartTime()+" 00:00:00");
            }
        }
        if(org.springframework.util.StringUtils.hasText(bo.getEndTime())){
            Matcher matcher = DATE_FORMAT.matcher(bo.getEndTime());
            boolean b = matcher.find();
            if(b){
                bo.setEndTime(bo.getEndTime()+" 23:59:59");
            }
        }

        LambdaQueryWrapper<ErpOrder> queryWrapper = new LambdaQueryWrapper<ErpOrder>()
                .eq(bo.getTenantId()!=null,ErpOrder::getTenantId,bo.getTenantId())
                .eq(bo.getShopId()!=null,ErpOrder::getShopId,bo.getShopId())
                .eq(bo.getOrderStatus()!=null,ErpOrder::getOrderStatus,bo.getOrderStatus())
                .eq(bo.getRefundStatus()!=null,ErpOrder::getRefundStatus,bo.getRefundStatus())
                .ge(org.springframework.util.StringUtils.hasText(bo.getStartTime()),ErpOrder::getOrderTime,bo.getStartTime())
                .le(org.springframework.util.StringUtils.hasText(bo.getEndTime()),ErpOrder::getOrderTime,bo.getEndTime())
                .eq(org.springframework.util.StringUtils.hasText(bo.getOrderNum()),ErpOrder::getOrderNum,bo.getOrderNum())
                .eq(org.springframework.util.StringUtils.hasText(bo.getReceiverName()),ErpOrder::getReceiverName,bo.getReceiverName())
                .eq(org.springframework.util.StringUtils.hasText(bo.getReceiverMobile()),ErpOrder::getReceiverMobile,bo.getReceiverMobile())
                ;
        Page<ErpOrder> pages = mapper.selectPage(pageQuery.build(), queryWrapper);

        // 查询子订单
        if(pages.getRecords()!=null){
            for (var order:pages.getRecords()) {
                order.setItemList(orderItemMapper.selectList(new LambdaQueryWrapper<ErpOrderItem>().eq(ErpOrderItem::getOrderId, order.getId())));
            }
        }

        return PageResult.build(pages);
    }

    @Override
    public ErpOrder queryDetailById(Long id) {
        ErpOrder order = mapper.selectById(id);
        if(order!=null){
            order.setItemList(orderItemMapper.selectList(new LambdaQueryWrapper<ErpOrderItem>().eq(ErpOrderItem::getOrderId, order.getId())));
        }
        return order;
    }

    @Transactional
    @Override
    public ResultVo<Integer> manualShipmentOrder(ErpOrderShipBo shipBo,String createBy) {
        if (StringUtils.isEmpty(shipBo.getId()) || shipBo.getId().equals("0"))
            return ResultVo.error(ResultVoEnum.ParamsError, "缺少参数：id");

        ErpOrder erpOrder = mapper.selectById(shipBo.getId());
        if (erpOrder == null) {
            return ResultVo.error("找不到订单数据");
        } else if (erpOrder.getOrderStatus().intValue() != 1 && erpOrder.getRefundStatus().intValue() != 1) {
            return ResultVo.error("订单状态不对，不允许发货");
        }
        ErpLogisticsCompany erpLogisticsCompany = erpLogisticsCompanyMapper.selectById(shipBo.getShippingCompany());
        if(erpLogisticsCompany==null) return ResultVo.error("快递公司选择错误");

        List<ErpOrderItem> oOrderItems = orderItemMapper.selectList(new LambdaQueryWrapper<ErpOrderItem>().eq(ErpOrderItem::getOrderId, erpOrder.getId()));
        if(oOrderItems==null) return ResultVo.error("订单 item 数据错误，无法发货！");
        // 添加发货记录
        ErpShipment erpShipment = new ErpShipment();
        erpShipment.setShipper(0);//发货方 0 仓库发货 1 供应商发货】
        erpShipment.setTenantId(erpOrder.getTenantId());
        erpShipment.setShopId(erpOrder.getShopId());
        erpShipment.setShopType(erpOrder.getShopType());
        erpShipment.setOrderId(erpOrder.getId());
        erpShipment.setOrderNum(erpOrder.getOrderNum());
        erpShipment.setShipType(1);//发货类型（1订单发货2商品补发3商品换货）
        erpShipment.setShipCompany(erpLogisticsCompany.getName());
        erpShipment.setShipCompanyCode(erpLogisticsCompany.getCode());
        erpShipment.setShipCode(shipBo.getShippingNumber());
        erpShipment.setShipFee(shipBo.getShippingCost());
        erpShipment.setShipTime(new Date());
        erpShipment.setShipOperator(shipBo.getShippingMan());
        erpShipment.setShipStatus(1);//物流状态（0 待发货1已发货2已完成）

        erpShipment.setPackageHeight(shipBo.getHeight());
        erpShipment.setPackageWeight(shipBo.getWeight());
        erpShipment.setPackageLength(shipBo.getLength());
        erpShipment.setPackageWidth(shipBo.getWidth());
        erpShipment.setPacksgeOperator(shipBo.getShippingMan());
//        erpShipment.setPackages(JSONObject.toJSONString(oOrderItems));
        erpShipment.setRemark(shipBo.getRemark());
        erpShipment.setCreateBy(createBy);
        erpShipment.setCreateTime(new Date());

        orderShippingMapper.insert(erpShipment);


        // 更新状态、发货方式
        ErpOrder update = new ErpOrder();
        update.setId(erpOrder.getId());
        update.setShipStatus(2);
        update.setOrderStatus(2);
        update.setUpdateTime(new Date());
        update.setUpdateBy("手动发货");
        mapper.updateById(update);

        return ResultVo.success();
    }

    @Override
    public List<SalesDailyVo> salesDaily(Long tenantId) {
        return mapper.salesDaily(tenantId);
    }
    @Override
    public SalesDailyVo getTodaySalesDaily(Long tenantId) {
        return mapper.getTodaySalesDaily(tenantId);
    }

    @Override
    public Integer getWaitShipOrderAllCount(Long tenantId) {
        return mapper.getWaitShipOrderAllCount(tenantId);
    }
}




