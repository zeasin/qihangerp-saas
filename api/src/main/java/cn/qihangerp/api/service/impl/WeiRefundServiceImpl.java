package cn.qihangerp.api.service.impl;

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
import cn.qihangerp.api.domain.ErpAfterSale;
import cn.qihangerp.api.domain.WeiRefund;
import cn.qihangerp.api.mapper.ErpAfterSaleMapper;
import cn.qihangerp.api.service.WeiRefundService;
import cn.qihangerp.api.mapper.WeiRefundMapper;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
* @author qilip
* @description 针对表【wei_refund(视频号小店退款)】的数据库操作Service实现
* @createDate 2024-04-04 23:11:44
*/
@AllArgsConstructor
@Service
public class WeiRefundServiceImpl extends ServiceImpl<WeiRefundMapper, WeiRefund>
    implements WeiRefundService{
    private final WeiRefundMapper mapper;
    private final ErpAfterSaleMapper afterSaleMapper;

    @Override
    public PageResult<WeiRefund> queryPageList(WeiRefund bo, PageQuery pageQuery) {
        LambdaQueryWrapper<WeiRefund> queryWrapper = new LambdaQueryWrapper<WeiRefund>()
                .eq(bo.getShopId()!=null,WeiRefund::getShopId,bo.getShopId())
                .eq(StringUtils.hasText(bo.getOrderId()),WeiRefund::getOrderId,bo.getOrderId())
                ;

        Page<WeiRefund> taoGoodsPage = mapper.selectPage(pageQuery.build(), queryWrapper);

        return PageResult.build(taoGoodsPage);
    }

    @Transactional
    @Override
    public ResultVo<Integer> saveRefund(Long shopId, WeiRefund refund) {
        try {
            List<WeiRefund> refunds = mapper.selectList(new LambdaQueryWrapper<WeiRefund>().eq(WeiRefund::getAfterSaleOrderId, refund.getAfterSaleOrderId()));
            if (refunds != null && refunds.size() > 0) {
                // 存在，修改
                WeiRefund update = new WeiRefund();
                update.setId(refunds.get(0).getId());
                update.setOrderId(refund.getOrderId());
                update.setStatus(refund.getStatus());
                update.setUpdateTime(refund.getUpdateTime());
                update.setReturnWaybillId(refund.getReturnWaybillId());
                update.setReturnDeliveryName(refund.getReturnDeliveryName());
                update.setReturnDeliveryId(refund.getReturnDeliveryId());
                update.setComplaintId(refund.getComplaintId());
                mapper.updateById(update);

                return ResultVo.error(ResultVoEnum.DataExist, "退款已经存在，更新成功");
            } else {
                // 不存在，新增
                refund.setShopId(shopId);
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
        WeiRefund refund = mapper.selectById(id);
        if(refund!=null && refund.getConfirmStatus()==null) {
            ErpAfterSale afterSale = new ErpAfterSale();
            afterSale.setType(10);
            afterSale.setShopId(refund.getShopId());
            afterSale.setShopType(EnumShopType.WEI.getIndex());
            afterSale.setAfterSaleOrderId(refund.getAfterSaleOrderId());
            afterSale.setOrderId(refund.getOrderId());
            afterSale.setProductId(refund.getProductId());
            afterSale.setSkuId(refund.getSkuId());
            afterSale.setCount(refund.getCount());
            // TODO：没有记录商品数据
            afterSale.setReturnCompany(refund.getReturnDeliveryName());
            afterSale.setReturnWaybillCode(refund.getReturnWaybillId());
            afterSale.setStatus(2);
            afterSale.setCreateBy("后台签收");
            afterSale.setCreateTime(new Date());
            afterSaleMapper.insert(afterSale);
            // 插入售后处理表
            WeiRefund complete = new WeiRefund();
            complete.setId(id.toString());
            complete.setConfirmStatus(9);
            complete.setConfirmTime(new Date());
            mapper.updateById(complete);
        }
        return ResultVo.success();
    }

    @Override
    public ResultVo<Integer> orderIntercept(Long id) {
        WeiRefund refund = mapper.selectById(id);
        if(refund!=null && refund.getConfirmStatus()==null) {
            ErpAfterSale afterSale = new ErpAfterSale();
            afterSale.setType(99);
            afterSale.setShopId(refund.getShopId());
            afterSale.setShopType(EnumShopType.WEI.getIndex());
            afterSale.setAfterSaleOrderId(refund.getAfterSaleOrderId());
            afterSale.setOrderId(refund.getOrderId());
            afterSale.setProductId(refund.getProductId());
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
            WeiRefund complete = new WeiRefund();
            complete.setId(id.toString());
            complete.setConfirmStatus(8);
            complete.setConfirmTime(new Date());
            mapper.updateById(complete);
        }
        return ResultVo.success();
    }
}




