package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.common.utils.DateUtils;
import cn.qihangerp.api.domain.*;
import cn.qihangerp.api.mapper.WmsStockOutMapper;
import cn.qihangerp.api.request.StockShipmentStockOutRequest;
import cn.qihangerp.api.service.WmsStockOutItemService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.service.ErpShipmentItemService;
import cn.qihangerp.api.mapper.ErpShipmentItemMapper;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

/**
* @author qihang
* @description 针对表【erp_shipment_item(发货明细表)】的数据库操作Service实现
* @createDate 2025-05-16 17:20:49
*/
@AllArgsConstructor
@Service
public class ErpShipmentItemServiceImpl extends ServiceImpl<ErpShipmentItemMapper, ErpShipmentItem>
    implements ErpShipmentItemService{
    private final WmsStockOutMapper outMapper;
    private final WmsStockOutItemService outItemService;

    @Override
    public PageResult<ErpShipmentItem> queryPageList(ErpShipmentItem bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpShipmentItem> queryWrapper = new LambdaQueryWrapper<ErpShipmentItem>()
                .eq(bo.getTenantId()!=null,ErpShipmentItem::getTenantId,bo.getTenantId())
                .eq(bo.getShipper()!=null,ErpShipmentItem::getShipper,bo.getShipper())
                .eq(bo.getStockStatus()!=null,ErpShipmentItem::getStockStatus,bo.getStockStatus())

                ;
        Page<ErpShipmentItem> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);

        return PageResult.build(pages);
    }

    /**
     * 确认出库--自己发货的商品出库--生成出库单--并更新状态
     * @param request
     * @param createBy
     * @param userId
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ResultVo stockOutConfirm(StockShipmentStockOutRequest request, String createBy, Long userId) {
        if(StringUtils.isBlank(request.getStockOutNum())){
            request.setStockOutNum(DateUtils.parseDateToStr("yyyyMMddHHmmss",new Date()));
        }
        List<ErpShipmentItem> erpShipmentItems = this.baseMapper.selectBatchIds(Arrays.stream(request.getIds()).toList());
        if(erpShipmentItems==null||erpShipmentItems.size()==0){
            return ResultVo.error("没有找到数据");
        }
        // 循环判断数据，状态
        long hasShip = erpShipmentItems.stream().filter(x -> x.getStockStatus() > 0).count();
        if(hasShip>0){
            return ResultVo.error("数据错误！存在已出库的订单商品数据！");
        }
        long supplierShip = erpShipmentItems.stream().filter(x -> x.getShipper() != 0).count();
        if(supplierShip>0){
            return ResultVo.error("数据错误！存在供应商发货的订单商品数据！");
        }

        // 添加出库单
        Map<Long, List<ErpShipmentItem>> goodsGroup = erpShipmentItems.stream().collect(Collectors.groupingBy(ErpShipmentItem::getErpGoodsId));

        Map<Long, List<ErpShipmentItem>> goodsSkuGroup = erpShipmentItems.stream().collect(Collectors.groupingBy(ErpShipmentItem::getErpSkuId));

        // z总数量
        Long total = erpShipmentItems.stream().mapToLong(ErpShipmentItem::getQuantity).sum();

        //添加主表信息
        ErpStockOut stockOut = new ErpStockOut();
        stockOut.setTenantId(userId);
        stockOut.setOutNum(request.getStockOutNum());
        stockOut.setType(1);
        stockOut.setSourceNum("");
        stockOut.setSourceId(0L);
        stockOut.setRemark("");
        stockOut.setCreateBy(createBy);
        stockOut.setCreateTime(new Date());

        stockOut.setGoodsUnit(goodsGroup.size());
        stockOut.setSpecUnit(goodsSkuGroup.size());
        stockOut.setSpecUnitTotal(total.intValue());
        stockOut.setOutTotal(0);
        stockOut.setOperatorId(userId.toString());
        stockOut.setOperatorName(createBy);
        stockOut.setPrintStatus(0);
        stockOut.setStatus(0);//状态：0待出库1部分出库2全部出库
        outMapper.insert(stockOut);

        //添加子表信息
//        List<WmsStockOutItem> itemList = new ArrayList<>();
        for(ErpShipmentItem item: erpShipmentItems) {
            ErpStockOutItem inItem = new ErpStockOutItem();
            inItem.setTenantId(stockOut.getTenantId());
            inItem.setEntryId(stockOut.getId());
            inItem.setType(stockOut.getType());
//            inItem.setBatchId(0L);
            inItem.setGoodsId(item.getErpGoodsId());
            inItem.setPurPrice(BigDecimal.ZERO);
            inItem.setSkuId(item.getErpSkuId());
            inItem.setSkuCode(item.getSkuNum());
            inItem.setGoodsName(item.getGoodsTitle());
            inItem.setGoodsNum(item.getGoodsNum());
            inItem.setSkuName(item.getGoodsSpec());
            inItem.setGoodsImage(item.getGoodsImg());
            inItem.setOriginalQuantity(item.getQuantity());
            inItem.setOutQuantity(0L);
            inItem.setStatus(0);
            inItem.setCreateBy(createBy);
            inItem.setCreateTime(new Date());
//            inItem.setWarehouseId(0L);
//            inItem.setPositionId(0L);
//            inItem.setPositionNum("");
            outItemService.save(inItem);
//            itemList.add(inItem);

            // 更新自己
            ErpShipmentItem itemUpdate = new ErpShipmentItem();
            itemUpdate.setId(item.getId());
            itemUpdate.setStockStatus(1);
            itemUpdate.setUpdateBy("确认出库");
            itemUpdate.setUpdateTime(new Date());

            this.baseMapper.updateById(itemUpdate);
        }
//        outItemService.saveBatch(itemList);
        return ResultVo.success();
    }
}




