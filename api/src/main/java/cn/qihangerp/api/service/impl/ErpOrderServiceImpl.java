package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.domain.vo.SalesDailyVo;
import cn.qihangerp.api.request.OrderSearchRequest;
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

    @Transactional
    @Override
    public ResultVo<Integer> shipErpOrder(ErpOrderShipBo shipBo) {
        if(shipBo.getOrderIds()==null||shipBo.getOrderIds().length==0) return ResultVo.error(ResultVoEnum.ParamsError,"请选择订单");
        if(shipBo.getShipType()==null) return ResultVo.error(ResultVoEnum.ParamsError,"请指定发货方式");
        for(String orderId:shipBo.getOrderIds()){
            ErpOrder erpOrder = mapper.selectById(orderId);
            if(erpOrder!=null){
                if(erpOrder.getOrderStatus()==0){
                    // 更新状态、发货方式
                    ErpOrder update = new ErpOrder();
                    update.setId(erpOrder.getId());
                    update.setShipType(shipBo.getShipType());
                    update.setOrderStatus(1);
                    update.setUpdateTime(new Date());
                    update.setUpdateBy("确认发货方式");
                    mapper.updateById(update);
                }
            }
        }
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




