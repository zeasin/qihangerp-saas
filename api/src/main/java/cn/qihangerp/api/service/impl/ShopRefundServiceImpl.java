package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.domain.*;
import cn.qihangerp.api.service.ShopOrderItemService;
import cn.qihangerp.api.service.ShopOrderService;
import cn.qihangerp.api.service.ShopService;
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
import cn.qihangerp.api.mapper.ErpOrderAfterSaleMapper;
import cn.qihangerp.api.service.ShopRefundService;
import cn.qihangerp.api.mapper.ShopRefundMapper;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

/**
* @author qilip
* @description 针对表【wei_refund(视频号小店退款)】的数据库操作Service实现
* @createDate 2024-04-04 23:11:44
*/
@AllArgsConstructor
@Service
public class ShopRefundServiceImpl extends ServiceImpl<ShopRefundMapper, ShopRefund>
    implements ShopRefundService {
    private final ShopRefundMapper mapper;
    private final ShopOrderService shopOrderService;
    private final ShopOrderItemService shopOrderItemService;
    private final ErpOrderAfterSaleMapper afterSaleMapper;
    private final ShopService shopService;

    @Override
    public PageResult<ShopRefund> queryPageList(ShopRefund bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ShopRefund> queryWrapper = new LambdaQueryWrapper<ShopRefund>()
                .eq(ShopRefund::getTenantId, bo.getTenantId())
                .eq(bo.getShopType()!=null,ShopRefund::getShopType, bo.getShopType())
                .eq(bo.getShopId()!=null, ShopRefund::getShopId,bo.getShopId())
                .eq(StringUtils.hasText(bo.getOrderId()), ShopRefund::getOrderId,bo.getOrderId())
                ;

        Page<ShopRefund> taoGoodsPage = mapper.selectPage(pageQuery.build(), queryWrapper);

        return PageResult.build(taoGoodsPage);
    }

    @Transactional
    @Override
    public ResultVo<Integer> saveRefund(Long shopId, ShopRefund refund) {
        Shop shop = shopService.getById(shopId);
        if(shop==null) return ResultVo.error("店铺不存在");

        try {
            List<ShopRefund> refunds = mapper.selectList(new LambdaQueryWrapper<ShopRefund>().eq(ShopRefund::getAfterSaleOrderId, refund.getAfterSaleOrderId()));
            if (refunds != null && refunds.size() > 0) {
                // 存在，修改
                ShopRefund update = new ShopRefund();
                update.setId(refunds.get(0).getId());
                update.setShopId(shopId);
                update.setTenantId(shop.getTenantId());
                update.setOrderId(refund.getOrderId());
                update.setStatus(refund.getStatus());
                update.setUpdateTime(refund.getUpdateTime());
                update.setReturnWaybillId(refund.getReturnWaybillId());
                update.setReturnDeliveryName(refund.getReturnDeliveryName());
                update.setReturnDeliveryId(refund.getReturnDeliveryId());
                update.setComplaintId(refund.getComplaintId());
                update.setUpdateOn(new Date());
                mapper.updateById(update);

                return ResultVo.error(ResultVoEnum.DataExist, "退款已经存在，更新成功");
            } else {
                // 不存在，新增
                refund.setShopId(shopId);
                refund.setTenantId(shop.getTenantId());
                refund.setCreateOn(new Date());
                mapper.insert(refund);
                return ResultVo.success();
            }
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultVo.error(ResultVoEnum.SystemException, "系统异常：" + e.getMessage());
        }
    }

    @Transactional
    @Override
    public ResultVo<Integer> returnedConfirm(Long id) {
        ShopRefund refund = mapper.selectById(id);
        if (refund == null) return ResultVo.error("没有找到店铺退款数据");
        if (refund.getConfirmStatus() != null && refund.getConfirmStatus() != 0)
            return ResultVo.error("店铺退款已处理");
        // 拼多多类型：售后类型 1：全部 2：仅退款 3：退货退款 4：换货 5：缺货补寄 6：维修
        // 微信小店类型： 售后类型。REFUND:退款；RETURN:退货退款。
        if (refund.getAfterSalesType() != 3 && !refund.getType().equals("RETURN"))
            return ResultVo.error("售后类型不是退款退货的售后无法处理");
        List<ShopOrder> shopOrders = shopOrderService.list(new LambdaQueryWrapper<ShopOrder>().eq(ShopOrder::getOrderId, refund.getOrderId()));
        if (shopOrders == null || shopOrders.isEmpty()) return ResultVo.error("没有找到店铺订单");

        // 查找子订单
        List<ShopOrderItem> shopOrderItems = shopOrderItemService.list(new LambdaQueryWrapper<ShopOrderItem>()
                .eq(ShopOrderItem::getShopOrderId, shopOrders.get(0).getId())
                .eq(ShopOrderItem::getSkuId, refund.getSkuId()));
        if (shopOrderItems == null || shopOrderItems.isEmpty()) return ResultVo.error("没有找到店铺订单item");


        // 插入售后处理数据
        ErpOrderAfterSale afterSale = new ErpOrderAfterSale();
        afterSale.setType(10);
        afterSale.setShopId(refund.getShopId());
        afterSale.setShopType(refund.getShopType());
        afterSale.setTenantId(refund.getTenantId());
        afterSale.setAfterSaleOrderId(refund.getAfterSaleOrderId());
        afterSale.setOrderId(refund.getOrderId());
        afterSale.setSubOrderId(shopOrders.get(0).getId());
        afterSale.setGoodsId(refund.getProductId());
        afterSale.setSkuId(refund.getSkuId());
        afterSale.setCount(refund.getCount());
        afterSale.setTitle(shopOrderItems.get(0).getTitle());
        afterSale.setImg(shopOrderItems.get(0).getThumbImg());
        afterSale.setSkuInfo(shopOrderItems.get(0).getSkuAttrs());
        afterSale.setSkuCode(shopOrderItems.get(0).getOutSkuId());
        afterSale.setErpGoodsId(shopOrderItems.get(0).getErpGoodsId());
        afterSale.setErpSkuId(shopOrderItems.get(0).getErpSkuId());
        afterSale.setShippingStatus(refund.getShippingStatus());
        // 用户是否发货
        if(StringUtils.hasText(refund.getReturnWaybillId())){
            afterSale.setUserShippingStatus(1);
            afterSale.setStatus(1);
        }else{
            afterSale.setUserShippingStatus(0);
            afterSale.setStatus(0);
        }
        afterSale.setReturnCompany(refund.getReturnDeliveryName());
        afterSale.setReturnWaybillCode(refund.getReturnWaybillId());

        afterSale.setCreateBy("后台确认售后");
        afterSale.setCreateTime(new Date());
        afterSaleMapper.insert(afterSale);
        // 更新店铺售后
        ShopRefund complete = new ShopRefund();
        complete.setId(id.toString());
        complete.setConfirmStatus(1);
        mapper.updateById(complete);

        return ResultVo.success();
    }

    /**
     * 拦截订单
     * @param id
     * @return
     */
    @Override
    public ResultVo<Integer> orderIntercept(Long id) {
        ShopRefund refund = mapper.selectById(id);
        if(refund!=null && refund.getConfirmStatus()==null) {
            ErpOrderAfterSale afterSale = new ErpOrderAfterSale();
            afterSale.setType(99);
            afterSale.setShopId(refund.getShopId());
            afterSale.setShopType(EnumShopType.WEI.getIndex());
            afterSale.setTenantId(refund.getTenantId());
            afterSale.setAfterSaleOrderId(refund.getAfterSaleOrderId());
            afterSale.setOrderId(refund.getOrderId());
            afterSale.setGoodsId(refund.getProductId());
            afterSale.setSkuId(refund.getSkuId());
            afterSale.setCount(refund.getCount());
            // TODO：没有记录商品数据
//            afterSale.setReturnCompany(refund.getReturnDeliveryName());
//            afterSale.setReturnWaybillCode(refund.getReturnWaybillId());
            afterSale.setStatus(2);
            afterSale.setCreateBy("后台拦截");
            afterSale.setCreateTime(new Date());
            afterSaleMapper.insert(afterSale);
            // 插入售后处理表
            ShopRefund complete = new ShopRefund();
            complete.setId(id.toString());
            complete.setConfirmStatus(8);
            complete.setConfirmTime(LocalDateTime.now());
            mapper.updateById(complete);
        }
        return ResultVo.success();
    }

    @Override
    public ShopRefund getRefundBy(String afterSaleOrderId) {
        List<ShopRefund> shopRefunds = mapper.selectList(new LambdaQueryWrapper<ShopRefund>().eq(ShopRefund::getAfterSaleOrderId, afterSaleOrderId));
        if(shopRefunds == null || shopRefunds.isEmpty()) return null;
        else return shopRefunds.get(0);
    }
}




