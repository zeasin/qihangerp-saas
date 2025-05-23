package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.common.ResultVoEnum;
import cn.qihangerp.api.common.utils.DateUtils;
import cn.qihangerp.api.domain.*;
import cn.qihangerp.api.mapper.ErpGoodsInventoryOperationMapper;
import cn.qihangerp.api.mapper.WmsStockOutItemPositionMapper;
import cn.qihangerp.api.mapper.WmsStockOutMapper;
import cn.qihangerp.api.request.GoodsSkuInventoryVo;
import cn.qihangerp.api.request.StockOutCreateRequest;
import cn.qihangerp.api.request.StockOutItemRequest;
import cn.qihangerp.api.service.ErpGoodsInventoryBatchService;
import cn.qihangerp.api.service.ErpGoodsInventoryService;
import cn.qihangerp.api.service.WmsStockOutItemService;
import cn.qihangerp.api.service.WmsStockOutService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
* @author qilip
* @description 针对表【wms_stock_out(出库单)】的数据库操作Service实现
* @createDate 2024-09-22 11:13:23
*/
@AllArgsConstructor
@Service
public class WmsStockOutServiceImpl extends ServiceImpl<WmsStockOutMapper, ErpStockOut>
    implements WmsStockOutService {
    private final WmsStockOutMapper outMapper;
    private final WmsStockOutItemService outItemService;
    private final ErpGoodsInventoryBatchService goodsInventoryBatchService;
    private final ErpGoodsInventoryService goodsInventoryService;
    private final ErpGoodsInventoryOperationMapper inventoryOperationMapper;
    private final WmsStockOutItemPositionMapper outItemPositionMapper;

    @Override
    public PageResult<ErpStockOut> queryPageList(ErpStockOut bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpStockOut> queryWrapper = new LambdaQueryWrapper<ErpStockOut>()
                .eq( ErpStockOut::getTenantId, bo.getTenantId())
                .eq( bo.getStatus()!=null, ErpStockOut::getStatus, bo.getStatus())
                .eq( bo.getType()!=null, ErpStockOut::getType, bo.getType())
                .eq(StringUtils.isNotBlank(bo.getOutNum()), ErpStockOut::getOutNum, bo.getOutNum())
                .eq(StringUtils.isNotBlank(bo.getSourceNum()), ErpStockOut::getSourceNum, bo.getSourceNum())
                .eq(bo.getSourceId()!=null, ErpStockOut::getSourceId, bo.getSourceId())
                ;

        Page<ErpStockOut> pages = outMapper.selectPage(pageQuery.build(), queryWrapper);
        return PageResult.build(pages);
    }


    @Transactional
    @Override
    public ResultVo<Long> createEntry(Long userId, String userName, StockOutCreateRequest request) {
        if(request.getType() == null ) return ResultVo.error(ResultVoEnum.ParamsError,"缺少参数type");
        if(request.getItemList().isEmpty()) return ResultVo.error(ResultVoEnum.ParamsError,"缺少参数itemList");
        if(StringUtils.isBlank(request.getOutNum())){
            request.setOutNum(DateUtils.parseDateToStr("yyyyMMddHHmmss",new Date()));
        }
        if(StringUtils.isBlank(request.getOperator())){
            request.setOperator(userName);
        }

        Map<Long, List<GoodsSkuInventoryVo>> goodsGroup = request.getItemList().stream().collect(Collectors.groupingBy(x -> x.getGoodsId()));
        Long total = request.getItemList().stream().mapToLong(GoodsSkuInventoryVo::getQuantity).sum();

        //添加主表信息
        ErpStockOut insert = new ErpStockOut();
        insert.setTenantId(userId);
        insert.setOutNum(request.getOutNum());
        insert.setType(request.getType());
//        insert.setShopId(request.getShopId());
//        insert.setShopGroupId(request.getShopGroupId());
        insert.setSourceNum(request.getSourceNo());
        insert.setSourceId(0L);
        insert.setRemark(request.getRemark());
        insert.setCreateBy(userName);
        insert.setCreateTime(new Date());
        insert.setGoodsUnit(goodsGroup.size());
        insert.setSpecUnit(request.getItemList().size());
        insert.setSpecUnitTotal(total.intValue());
        insert.setOutTotal(0);
        insert.setOperatorId(userId.toString());
        insert.setOperatorName(StringUtils.isEmpty(request.getOperator())?userName:request.getOperator());
        insert.setPrintStatus(0);
        insert.setRemark(request.getRemark());
        insert.setStatus(0);//状态（0待入库1部分入库2全部入库）
        outMapper.insert(insert);

        //添加子表信息
        List<ErpStockOutItem> itemList = new ArrayList<>();
        for(GoodsSkuInventoryVo item: request.getItemList()) {

            ErpStockOutItem inItem = new ErpStockOutItem();
//            inItem.setShopId(request.getShopId());
//            inItem.setShopGroupId(request.getShopGroupId());
            inItem.setTenantId(insert.getTenantId());
            inItem.setEntryId(insert.getId());
            inItem.setType(request.getType());
            inItem.setGoodsId(item.getGoodsId());
            inItem.setPurPrice(item.getPurPrice());
            inItem.setSkuId(item.getSkuId());
            inItem.setSkuCode(item.getSkuCode());
            inItem.setGoodsName(item.getGoodsName());
            inItem.setGoodsNum(item.getGoodsNum());
            inItem.setSkuName(item.getSkuName());
            inItem.setGoodsImage(item.getGoodsImg());
            inItem.setOriginalQuantity(item.getQuantity());
            inItem.setOutQuantity(0L);
            inItem.setStatus(0);
            inItem.setCreateBy(userName);
            inItem.setCreateTime(new Date());
//                    inItem.setWarehouseId(batch.getWarehouseId());
//                    inItem.setPositionId(batch.getPositionId());
//                    inItem.setPositionNum(batch.getPositionNum());
            itemList.add(inItem);


        }
        outItemService.saveBatch(itemList);
        return ResultVo.success();
    }

    @Override
    public ErpStockOut getDetailAndItemById(Long id) {
        ErpStockOut erpStockOut = outMapper.selectById(id);
        if(erpStockOut !=null){
            List<ErpStockOutItem> outItemList = outItemService.list(new LambdaQueryWrapper<ErpStockOutItem>().eq(ErpStockOutItem::getEntryId, id));
            if(outItemList!=null && outItemList.size()>0){
                // 查找outItem skuid相对应的库存批次list
                for(ErpStockOutItem item: outItemList){
                    item.setOutQty(item.getOriginalQuantity()-item.getOutQuantity());
                    List<ErpGoodsInventoryBatch> erpGoodsInventoryBatches = goodsInventoryBatchService.querySkuBatchList(item.getSkuId());
                    item.setInventoryBatchList(erpGoodsInventoryBatches);
                }

            }
            erpStockOut.setItemList(outItemList);
        }
        return erpStockOut;
    }

    @Transactional
    @Override
    public ResultVo<Long> stockOut(Long userId, String userName, StockOutItemRequest request) {
        if(request.getEntryItemId() == null) return ResultVo.error(1500,"缺少参数：outItemId");
        if(request.getOutQty()==null || request.getOutQty().longValue()<=0) return ResultVo.error(1500,"缺少参数：出库数量");

        ErpStockOutItem outItem = outItemService.getById(request.getEntryItemId());
        if(outItem == null) return ResultVo.error(1500,"出库数据错误");
        // 判断库存够不够扣减的
        ErpGoodsInventoryBatch batch = goodsInventoryBatchService.getById(request.getInventoryBatchId());
        if(batch == null) return ResultVo.error(1500,"库存数据不存在");
        if(batch.getCurrentQty().longValue()< request.getOutQty().longValue())
            return ResultVo.error(1500,"库存不足");
        if(StringUtils.isEmpty(batch.getRemark())) batch.setRemark("");
        // 扣减库存
        // 1扣减批次库存
        ErpGoodsInventoryBatch updateBatch = new ErpGoodsInventoryBatch();
        updateBatch.setCurrentQty(batch.getCurrentQty() - request.getOutQty());
        updateBatch.setUpdateBy(userName);
        updateBatch.setUpdateTime(new Date());
        updateBatch.setRemark(batch.getRemark()+"出库扣减库存；");
        updateBatch.setId(batch.getId());
        goodsInventoryBatchService.updateById(updateBatch);
        // 2扣减总库存
        ErpGoodsInventory goodsInventory = goodsInventoryService.getById(batch.getInventoryId());
        ErpGoodsInventory updateInventory = new ErpGoodsInventory();
        updateInventory.setId(goodsInventory.getId());
        updateInventory.setQuantity(goodsInventory.getQuantity() - request.getOutQty());
        updateInventory.setUpdateBy(userName);
        updateInventory.setUpdateTime(new Date());
        goodsInventoryService.updateById(updateInventory);


        // 添加item
        ErpStockOutItemPosition outItemPosition = new ErpStockOutItemPosition();
        outItemPosition.setTenantId(outItem.getTenantId());
        outItemPosition.setOutId(outItem.getEntryId());
        outItemPosition.setItemId(outItem.getId());
        outItemPosition.setGoodsInventoryId(batch.getInventoryId());
        outItemPosition.setGoodsInventoryBatchId(batch.getId());
        outItemPosition.setQuantity(request.getOutQty());
        outItemPosition.setOperatorId(userId);
        outItemPosition.setOperatorName(userName);
        outItemPosition.setOutTime(new Date());
        outItemPosition.setWarehouseId(batch.getWarehouseId());
        outItemPosition.setPositionId(batch.getPositionId());
        outItemPosition.setPositionNum(batch.getPositionNum());
        outItemPositionMapper.insert(outItemPosition);

        // 添加库存明细
        ErpGoodsInventoryOperation operation = new ErpGoodsInventoryOperation();
        operation.setTenantId(outItem.getTenantId());
        operation.setGoodsId(outItem.getGoodsId());
        operation.setGoodsNum(outItem.getGoodsNum());
        operation.setSkuId(outItem.getSkuId());
        operation.setSkuCode(outItem.getSkuCode());
        operation.setBatchId(batch.getId());
        operation.setBatchNum(batch.getBatchNum());
        operation.setType(2);//库存类型（1增加库存2减少库存3锁定库存）
        operation.setInventoryId(batch.getInventoryId());
        operation.setQuantity(request.getOutQty());
        operation.setLockedQuantity(0);
        operation.setPrice(batch.getPurPrice());
        // 出库类型1订单拣货出库2采购退货出库3盘点出库4报损出库
        if(outItem.getType().intValue()==1){
            operation.setBizType(202);//业务类型（101采购入库102销售退货入库201采购退货出库202订单发货出库203订单补发出库211盘点出库212报损出库999其他出库）
        }else  if(outItem.getType().intValue()==2){
            operation.setBizType(201);
        }else  if(outItem.getType().intValue()==3){
            operation.setBizType(211);
        }else  if(outItem.getType().intValue()==4){
            operation.setBizType(212);
        }
        operation.setBizId(outItemPosition.getId());
        operation.setBizNum("");
        operation.setBizItemId(0L);
        operation.setWarehouseId(batch.getWarehouseId());
        operation.setPositionId(batch.getPositionId());
        operation.setPositionNum(batch.getPositionNum());
        operation.setStatus(0);
        operation.setCreateTime(new Date());
        operation.setUpdateTime(new Date());
        inventoryOperationMapper.insert(operation);

        // 更新自己的状态
        ErpStockOutItem outItemUpdate = new ErpStockOutItem();
        outItemUpdate.setId(outItem.getId());
        outItemUpdate.setStatus(2);
        outItemUpdate.setCompleteTime(new Date());
        outItemUpdate.setOutQuantity(outItem.getOutQuantity()+ request.getOutQty());
        outItemUpdate.setUpdateBy(userName);
        outItemUpdate.setUpdateTime(new Date());
        outItemService.updateById(outItemUpdate);

        // 更新主表单数据
        ErpStockOut erpStockOut = outMapper.selectById(outItem.getEntryId());
        if(erpStockOut.getOutTotal()==null) erpStockOut.setOutTotal(0);
        // 查询入库表单是否入库完成
        List<ErpStockOutItem> itemList = outItemService.list(new LambdaQueryWrapper<ErpStockOutItem>().eq(ErpStockOutItem::getEntryId,outItem.getEntryId()).ne(ErpStockOutItem::getStatus, 2));
        ErpStockOut sUpdate = new ErpStockOut();
        if (itemList.isEmpty()) {
            // 全部入库完成了
            sUpdate.setStatus(2);
            sUpdate.setCompleteTime(new Date());
        } else {
            // 部分入库
            sUpdate.setStatus(1);
        }

        sUpdate.setId(outItem.getEntryId());
        sUpdate.setOperatorId(userId.toString());
        sUpdate.setOperatorName(userName);
        sUpdate.setOutTime(new Date());
        sUpdate.setOutTotal(erpStockOut.getOutTotal()+request.getOutQty().intValue());
        sUpdate.setUpdateBy(userName);
        sUpdate.setUpdateTime(new Date());
        outMapper.updateById(sUpdate);

        return ResultVo.success();
    }
}




