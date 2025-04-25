package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.utils.DateUtils;
import cn.qihangerp.api.request.ShopOrderSearchRequest;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.StringUtils;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.common.ResultVoEnum;
import cn.qihangerp.api.common.enums.EnumShopType;
import cn.qihangerp.api.domain.ErpOrder;
import cn.qihangerp.api.domain.ErpOrderItem;
import cn.qihangerp.api.domain.ShopOrder;
import cn.qihangerp.api.domain.ShopOrderItem;
import cn.qihangerp.api.mapper.ErpOrderItemMapper;
import cn.qihangerp.api.mapper.ErpOrderMapper;
import cn.qihangerp.api.mapper.ShopOrderItemMapper;
import cn.qihangerp.api.service.ShopOrderService;
import cn.qihangerp.api.mapper.ShopOrderMapper;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
* @author qilip
* @description 针对表【wei_order】的数据库操作Service实现
* @createDate 2024-04-03 21:36:32
*/
@AllArgsConstructor
@Service
public class ShopOrderServiceImpl extends ServiceImpl<ShopOrderMapper, ShopOrder>
    implements ShopOrderService {
    private final ShopOrderMapper mapper;
    private final ShopOrderItemMapper itemMapper;
    private final ErpOrderMapper erpOrderMapper;
    private final ErpOrderItemMapper erpOrderItemMapper;

    private final String DATE_PATTERN =
            "^(?:(?:(?:\\d{4}-(?:0?[1-9]|1[0-2])-(?:0?[1-9]|1\\d|2[0-8]))|(?:(?:(?:\\d{2}(?:0[48]|[2468][048]|[13579][26])|(?:(?:0[48]|[2468][048]|[13579][26])00))-0?2-29))$)|(?:(?:(?:\\d{4}-(?:0?[13578]|1[02]))-(?:0?[1-9]|[12]\\d|30))$)|(?:(?:(?:\\d{4}-0?[13-9]|1[0-2])-(?:0?[1-9]|[1-2]\\d|30))$)|(?:(?:(?:\\d{2}(?:0[48]|[13579][26]|[2468][048])|(?:(?:0[48]|[13579][26]|[2468][048])00))-0?2-29))$)$";
    private final Pattern DATE_FORMAT = Pattern.compile(DATE_PATTERN);
    @Override
    public PageResult<ShopOrder> queryPageList(ShopOrderSearchRequest bo, PageQuery pageQuery) {
        Long startTime = null;
        Long endTime = null;

        if(org.springframework.util.StringUtils.hasText(bo.getStartTime())){
            Matcher matcher = DATE_FORMAT.matcher(bo.getStartTime());
            boolean b = matcher.find();
            if(b){
//                bo.setStartTime(bo.getStartTime()+" 00:00:00");
               startTime = DateUtils.parseDate(bo.getStartTime()+" 00:00:00").getTime() /1000;
            }
        }
        if(org.springframework.util.StringUtils.hasText(bo.getEndTime())){
            Matcher matcher = DATE_FORMAT.matcher(bo.getEndTime());
            boolean b = matcher.find();
            if(b){
//                bo.setEndTime(bo.getEndTime()+" 23:59:59");
                endTime = DateUtils.parseDate(bo.getEndTime()+" 23:59:59").getTime() /1000;
            }
        }
        pageQuery.setOrderByColumn("create_time");
        pageQuery.setIsAsc("desc");


        LambdaQueryWrapper<ShopOrder> queryWrapper = new LambdaQueryWrapper<ShopOrder>()
                .eq(ShopOrder::getTenantId,bo.getTenantId())
                .eq(bo.getStatus()!=null, ShopOrder::getStatus,bo.getStatus())
                .eq(bo.getShopId()!=null, ShopOrder::getShopId,bo.getShopId())
                .ge(startTime!=null, ShopOrder::getCreateTime,startTime)
                .le(endTime!=null, ShopOrder::getCreateTime,endTime)
                .eq(StringUtils.hasText(bo.getOrderId()), ShopOrder::getOrderId,bo.getOrderId())
                ;

        Page<ShopOrder> taoGoodsPage = mapper.selectPage(pageQuery.build(), queryWrapper);
        if(taoGoodsPage.getRecords()!=null){
            for (var order:taoGoodsPage.getRecords()) {
                order.setItems(itemMapper.selectList(new LambdaQueryWrapper<ShopOrderItem>().eq(ShopOrderItem::getShopOrderId,order.getId())));
            }
        }
        return PageResult.build(taoGoodsPage);
    }

    @Transactional
    @Override
    public ResultVo<Long> saveOrder(Long shopId, ShopOrder order) {
        try {
            List<ShopOrder> orders = mapper.selectList(new LambdaQueryWrapper<ShopOrder>().eq(ShopOrder::getOrderId, order.getOrderId()));
            if (orders != null && orders.size() > 0) {
                // 存在，修改
                ShopOrder update = new ShopOrder();
                update.setId(orders.get(0).getId());
                update.setStatus(order.getStatus());
                update.setUpdateTime(order.getUpdateTime());
                update.setPayInfo(order.getPayInfo());
                update.setAftersaleDetail(order.getAftersaleDetail());
                update.setDeliveryProductInfo(order.getDeliveryProductInfo());

                mapper.updateById(update);
                // 更新item
                for (var item : order.getItems()) {
                    List<ShopOrderItem> taoOrderItems = itemMapper.selectList(new LambdaQueryWrapper<ShopOrderItem>().eq(ShopOrderItem::getSkuId, item.getSkuId()));
                    if (taoOrderItems != null && taoOrderItems.size() > 0) {
                        // 不处理
                    } else {
                        // 新增
                        item.setShopId(shopId);
                        item.setShopOrderId(update.getId());
                        itemMapper.insert(item);
                    }
                }
                return ResultVo.error(ResultVoEnum.DataExist.getIndex(), "订单已经存在，更新成功",Long.parseLong(update.getId()));
            } else {
                // 不存在，新增
                order.setShopId(shopId);
                mapper.insert(order);
                // 添加item
                for (var item : order.getItems()) {
                    item.setShopId(shopId);
                    item.setShopOrderId(order.getId());
                    itemMapper.insert(item);
                }
                return ResultVo.success(Long.parseLong(order.getId()));
            }
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultVo.error(ResultVoEnum.SystemException, "系统异常：" + e.getMessage());
        }
    }

    @Transactional
    @Override
    public ResultVo<Integer> orderConfirm(String[] ids) {
        if(ids!=null && ids.length >0) {
            Integer success =0;
            for(var id : ids){
                if(StringUtils.hasText(id)) {
                    // 查询订单
                    ShopOrder weiOrder = mapper.selectById(id);
                    if(weiOrder!=null){
                        // 查询是否确认过
                        if(weiOrder.getConfirmStatus() == null || weiOrder.getConfirmStatus() == 0){
                            // 确认状态是null或者0
                            List<ErpOrder> erpOrders = erpOrderMapper.selectList(new LambdaQueryWrapper<ErpOrder>().eq(ErpOrder::getOrderNum, weiOrder.getOrderId()).eq(ErpOrder::getShopId, weiOrder.getShopId()));
                            if(erpOrders==null||erpOrders.size()==0){
                                // 没有数据，开始插入订单数据
                                ErpOrder insert = new ErpOrder();
                                insert.setTenantId(weiOrder.getTenantId());
                                insert.setOrderNum(weiOrder.getOrderId());
                                insert.setShopType(EnumShopType.WEI.getIndex());
                                insert.setShopId(weiOrder.getShopId());
                                insert.setRefundStatus(1);
                                insert.setOrderStatus(0);
                                insert.setGoodsAmount(weiOrder.getProductPrice().doubleValue()/100);
                                insert.setAmount(weiOrder.getOrderPrice().doubleValue()/100);
                                insert.setReceiverName(weiOrder.getUserName());
                                insert.setReceiverMobile(weiOrder.getTelNumber());
                                insert.setProvince(weiOrder.getProvinceName());
                                insert.setCity(weiOrder.getCityName());
                                insert.setTown(weiOrder.getCountyName());
                                insert.setAddress(weiOrder.getDetailInfo());
                                insert.setShipType(-1);
                                insert.setOrderTime(new Date(weiOrder.getCreateTime() *1000));
                                insert.setCreateTime(new Date());
                                insert.setCreateBy("手动确认");
                                erpOrderMapper.insert(insert);

                                // 插入order_item
                                List<ShopOrderItem> weiOrderItems = itemMapper.selectList(new LambdaQueryWrapper<ShopOrderItem>().eq(ShopOrderItem::getShopOrderId, weiOrder.getId()));
                                for(var item :weiOrderItems) {
                                    ErpOrderItem itemInsert = new ErpOrderItem();
                                    itemInsert.setTenantId(weiOrder.getTenantId());
                                    itemInsert.setShopId(weiOrder.getShopId());
                                    itemInsert.setOrderId(insert.getId());
                                    itemInsert.setOrderNum(weiOrder.getOrderId());
                                    itemInsert.setSubOrderNum(item.getId()+"");
                                    itemInsert.setSkuId(item.getSkuId());
                                    // TODO:skuId需要查询erp系统的
                                    itemInsert.setErpGoodsId(0L);
                                    itemInsert.setErpSkuId(0L);
                                    itemInsert.setGoodsTitle(item.getTitle());
                                    itemInsert.setGoodsImg(item.getThumbImg());
                                    itemInsert.setGoodsNum("");
                                    itemInsert.setSkuNum("");
                                    itemInsert.setGoodsSpec(item.getSkuAttrs());
                                    if(item.getMarketPrice()!=null) {
                                        itemInsert.setGoodsPrice(item.getMarketPrice().doubleValue() / 100);
                                    }
                                    if(item.getRealPrice()!=null){
                                        itemInsert.setItemAmount(item.getRealPrice().doubleValue()/100);
                                    }
                                    itemInsert.setQuantity(item.getSkuCnt());
                                    itemInsert.setRefundCount(0);
                                    itemInsert.setRefundStatus(1);
                                    erpOrderItemMapper.insert(itemInsert);
                                }
                                // 更新wei_order确认状态
                                ShopOrder update = new ShopOrder();
                                update.setId(weiOrder.getId());
                                update.setConfirmStatus(1);
                                update.setConfirmTime(new Date());
                                mapper.updateById(update);
                                success++;
                            }
                        }
                    }
                }
            }
            return ResultVo.success(success);
        }else {
            return ResultVo.error(ResultVoEnum.ParamsError, "没有订单ID：");
        }
    }
}




