package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.common.ResultVoEnum;
import cn.qihangerp.api.common.utils.DateUtils;
import cn.qihangerp.api.domain.*;
import cn.qihangerp.api.mapper.ErpGoodsInventoryOperationMapper;
import cn.qihangerp.api.mapper.WmsStockInItemPositionMapper;
import cn.qihangerp.api.mapper.WmsStockInMapper;
import cn.qihangerp.api.mapper.WmsWarehousePositionMapper;
import cn.qihangerp.api.request.StockInCreateItem;
import cn.qihangerp.api.request.StockInCreateRequest;
import cn.qihangerp.api.request.StockInItem;
import cn.qihangerp.api.request.StockInRequest;
import cn.qihangerp.api.service.*;
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
* @description 针对表【wms_stock_in(入库单)】的数据库操作Service实现
* @createDate 2024-09-22 16:10:08
*/
@AllArgsConstructor
@Service
public class WmsStockInServiceImpl extends ServiceImpl<WmsStockInMapper, ErpStockIn>
    implements WmsStockInService {
    private final WmsStockInMapper mapper;
    private final WmsStockInItemService inItemService;
    private final WmsStockInItemPositionMapper inItemPositionMapper;
    private final WmsWarehousePositionMapper warehousePositionMapper;
    private final ErpGoodsInventoryBatchService inventoryBatchService;
    private final ErpGoodsInventoryOperationMapper inventoryOperationMapper;
    private final ErpGoodsInventoryService inventoryService;
    private final ErpGoodsSkuService skuService;
    private final ErpGoodsService goodsService;
    @Override
    public PageResult<ErpStockIn> queryPageList(ErpStockIn bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpStockIn> queryWrapper = new LambdaQueryWrapper<ErpStockIn>()
                .eq(ErpStockIn::getTenantId,bo.getTenantId())
                .eq( bo.getStatus()!=null, ErpStockIn::getStatus, bo.getStatus())
                .eq( bo.getStockInType()!=null, ErpStockIn::getStockInType, bo.getStockInType())
                .eq(StringUtils.isNotBlank(bo.getStockInNum()), ErpStockIn::getStockInNum, bo.getStockInNum())
                .eq(StringUtils.isNotBlank(bo.getSourceNo()), ErpStockIn::getSourceNo, bo.getSourceNo())
                .eq(bo.getSourceId()!=null, ErpStockIn::getSourceId, bo.getSourceId())
            ;

        Page<ErpStockIn> pages = mapper.selectPage(pageQuery.build(), queryWrapper);
        return PageResult.build(pages);
    }

    @Transactional
    @Override
    public ResultVo<Long> createEntry(Long userId, String userName, StockInCreateRequest request) {
        if(request.getStockInType() == null ) return ResultVo.error(ResultVoEnum.ParamsError,"缺少参数stockInType");
        if(request.getItemList().isEmpty()) return ResultVo.error(ResultVoEnum.ParamsError,"缺少参数itemList");
        if(StringUtils.isBlank(request.getStockInNum())){
            request.setStockInNum(DateUtils.parseDateToStr("yyyyMMddHHmmss",new Date()));
        }
        if(StringUtils.isBlank(request.getStockInOperator())){
            request.setStockInOperator(userName);
        }

        Map<String, List<StockInCreateItem>> goodsGroup = request.getItemList().stream().collect(Collectors.groupingBy(x -> x.getGoodsId()));
        Long total = request.getItemList().stream().mapToLong(StockInCreateItem::getQuantity).sum();
        //添加主表信息
        ErpStockIn insert = new ErpStockIn();
        insert.setTenantId(userId);
        insert.setStockInNum(request.getStockInNum());
        insert.setStockInType(request.getStockInType());
        insert.setStockInOperator(request.getStockInOperator());
        insert.setStockInOperatorId(userId+"");
//        insert.setStockInTime(new Date());
        insert.setSourceNo(request.getSourceNo());
        insert.setRemark(request.getRemark());
        insert.setCreateBy(userName);
        insert.setCreateTime(new Date());
        insert.setSourceGoodsUnit(goodsGroup.size());
        insert.setSourceSpecUnit(request.getItemList().size());
        insert.setSourceSpecUnitTotal(total.intValue());
        insert.setStatus(0);//状态（0待入库1部分入库2全部入库）
        mapper.insert(insert);

        //添加子表信息
        List<ErpStockInItem> itemList = new ArrayList<>();
        for(StockInCreateItem item: request.getItemList()){
            if(item.getSkuId()!=null) {
                ErpGoodsSku goodsSku = skuService.getById(item.getSkuId());
                if(goodsSku!=null) {
                    ErpGoods goods = goodsService.getById(goodsSku.getGoodsId());
                    ErpStockInItem inItem = new ErpStockInItem();
                    inItem.setTenantId(insert.getTenantId());
                    inItem.setStockInId(insert.getId());
                    inItem.setStockInType(insert.getStockInType());
                    inItem.setSourceNo(insert.getSourceNo());
                    inItem.setSourceId(0L);
                    inItem.setSourceItemId(0L);
                    inItem.setGoodsId(goodsSku.getGoodsId());
                    inItem.setGoodsName(item.getGoodsName());
                    inItem.setGoodsImage(item.getGoodsImg());
                    inItem.setGoodsNum(goods!=null?goods.getNumber():"");
                    inItem.setSkuName(item.getSkuName());
                    inItem.setSkuId(item.getSkuId());
                    inItem.setSkuCode(item.getSkuCode());
                    inItem.setQuantity(item.getQuantity());
                    inItem.setInQuantity(0);
                    inItem.setPurPrice(item.getPurPrice()==null? 0.0 : item.getPurPrice());
                    inItem.setStatus(0);
                    inItem.setCreateBy(userName);
                    inItem.setCreateTime(new Date());
                    itemList.add(inItem);
                }
            }
        }
        inItemService.saveBatch(itemList);
        return ResultVo.success();
    }

    @Transactional
    @Override
    public ResultVo<Long> stockIn(Long tenantId, String userName, StockInRequest request) {
        if (request.getStockInId() == null) return ResultVo.error(ResultVoEnum.ParamsError, "缺少参数stockInId");
//        if (request.getWarehouseId() == null) return ResultVo.error(ResultVoEnum.ParamsError, "缺少参数warehouseId");
        if (request.getItemList().isEmpty()) return ResultVo.error(ResultVoEnum.ParamsError, "缺少入库数据");

        ErpStockIn erpStockIn = mapper.selectById(request.getStockInId());
        if (erpStockIn == null) return ResultVo.error(ResultVoEnum.NotFound, "没有找到入库单");
        else if (erpStockIn.getStatus() == 2) {
            return ResultVo.error(ResultVoEnum.SystemException, "入库单状态不能入库");
        }

        List<StockInItem> waitList = new ArrayList<>();
        for (StockInItem item : request.getItemList()) {
            if (item.getQty() != null && item.getQty() > 0 && item.getPositionId() != null && item.getPositionId() > 0) {
                waitList.add(item);
            }
        }
        if (waitList.size() == 0) return ResultVo.error(ResultVoEnum.ParamsError, "缺少入库明细数据");

        // 开始入库
        for (StockInItem item : waitList) {
            // 查询明细
            ErpStockInItem stockInItem = inItemService.getById(item.getId());
            if (stockInItem == null) {
                return ResultVo.error(ResultVoEnum.DataError, "数据错误！没有找到入库单明细");
            }
            // 查询仓位
            ErpWarehousePosition warehousePosition = warehousePositionMapper.selectById(item.getPositionId());
            if (warehousePosition == null) {
                return ResultVo.error("仓库仓位不存在！");
            }


            // 添加库存操作表

            String goodsInventoryId;
            int beforQty=0;
            // 增加商品库存表
            List<ErpGoodsInventory> inventoryList = inventoryService.list(new LambdaQueryWrapper<ErpGoodsInventory>().eq(ErpGoodsInventory::getSkuId, stockInItem.getSkuId()));
            if (inventoryList.isEmpty()) {
                // 新增
                ErpGoodsInventory inventory = new ErpGoodsInventory();
                inventory.setTenantId(tenantId);
                inventory.setGoodsId(stockInItem.getGoodsId());
                inventory.setGoodsNum(stockInItem.getGoodsNum());
                inventory.setSkuId(stockInItem.getSkuId());
                inventory.setSkuCode(stockInItem.getSkuCode());
                inventory.setGoodsName(stockInItem.getGoodsName());
                inventory.setGoodsImg(stockInItem.getGoodsImage());
                inventory.setSkuName(stockInItem.getSkuName());
                inventory.setQuantity(item.getQty());
                inventory.setIsDelete(0);
                inventory.setCreateBy(userName);
                inventory.setCreateTime(new Date());
                inventoryService.save(inventory);
                goodsInventoryId = inventory.getId();
            } else {
                //修改
                ErpGoodsInventory update = new ErpGoodsInventory();
                update.setId(inventoryList.get(0).getId());
                update.setUpdateBy(userName);
                update.setUpdateTime(new Date());
                update.setQuantity(inventoryList.get(0).getQuantity() + item.getQty());
                inventoryService.updateById(update);
                goodsInventoryId = inventoryList.get(0).getId();
                beforQty = inventoryList.get(0).getQuantity();
            }

            // 增加商品库存批次表
            ErpGoodsInventoryBatch inventoryBatch = new ErpGoodsInventoryBatch();
            inventoryBatch.setTenantId(tenantId);
            inventoryBatch.setInventoryId(Long.parseLong(goodsInventoryId));
            inventoryBatch.setBatchNum(DateUtils.parseDateToStr("yyyyMMddHHmmss", new Date()));
            inventoryBatch.setOriginQty(item.getQty());
            inventoryBatch.setCurrentQty(item.getQty());
            inventoryBatch.setPurPrice(stockInItem.getPurPrice());
            inventoryBatch.setPurId(0L);
            inventoryBatch.setPurItemId(0L);
            inventoryBatch.setSkuId(stockInItem.getSkuId());
            inventoryBatch.setSkuCode(stockInItem.getSkuCode());
            inventoryBatch.setGoodsId(stockInItem.getGoodsId());
            inventoryBatch.setWarehouseId(warehousePosition.getWarehouseId());
            inventoryBatch.setPositionId(item.getPositionId());
            inventoryBatch.setPositionNum(item.getPositionNum());
            inventoryBatch.setCreateTime(new Date());
            inventoryBatch.setCreateBy(userName);
            inventoryBatchService.save(inventoryBatch);



            // 添加itemPosition
            ErpStockInItemPosition stockInItemPosition = new ErpStockInItemPosition();
            stockInItemPosition.setTenantId(tenantId);
            stockInItemPosition.setInId(erpStockIn.getId());
            stockInItemPosition.setItemId(item.getId());
            stockInItemPosition.setGoodsInventoryId(Long.parseLong(goodsInventoryId));
            stockInItemPosition.setGoodsInventoryBatchId(inventoryBatch.getId());
            stockInItemPosition.setQuantity(item.getQty());
            stockInItemPosition.setOperatorId(tenantId);
            stockInItemPosition.setOperatorName(userName);
            stockInItemPosition.setCreateTime(new Date());
            stockInItemPosition.setWarehouseId(warehousePosition.getWarehouseId());
            stockInItemPosition.setPositionId(warehousePosition.getId());
            stockInItemPosition.setPositionNum(warehousePosition.getNumber());
            inItemPositionMapper.insert(stockInItemPosition);

            // 添加库存明细
            ErpGoodsInventoryOperation operation = new ErpGoodsInventoryOperation();
            operation.setTenantId(tenantId);
            operation.setGoodsId(stockInItem.getGoodsId());
            operation.setGoodsNum(stockInItem.getGoodsNum());
            operation.setSkuId(stockInItem.getSkuId());
            operation.setSkuCode(stockInItem.getSkuCode());
            operation.setBatchId(inventoryBatch.getId());
            operation.setBatchNum(inventoryBatch.getBatchNum());
            operation.setType(1);//库存类型（1增加库存2减少库存3锁定库存）
            operation.setInventoryId(inventoryBatch.getInventoryId());
            operation.setQuantity(item.getQty());
            operation.setLockedQuantity(0);
            operation.setPrice(inventoryBatch.getPurPrice());
            // 来源类型（1采购订单2退货订单）
            if(erpStockIn.getStockInType().intValue()==1){
                operation.setBizType(101);//业务类型（101采购入库102销售退货入库201采购退货出库202订单发货出库203订单补发出库999其他出库）
            }else  if(erpStockIn.getStockInType().intValue()==2){
                operation.setBizType(102);
            }
            operation.setBizId(stockInItemPosition.getId());
            operation.setBizNum("");
            operation.setBizItemId(0L);
            operation.setWarehouseId(inventoryBatch.getWarehouseId());
            operation.setPositionId(inventoryBatch.getPositionId());
            operation.setPositionNum(inventoryBatch.getPositionNum());
            operation.setStatus(0);
            operation.setCreateTime(new Date());
            operation.setUpdateTime(new Date());
            inventoryOperationMapper.insert(operation);

            // 回写状态
            ErpStockInItem update = new ErpStockInItem();
            update.setId(stockInItem.getId());
            update.setInQuantity(stockInItem.getInQuantity() + item.getQty());
            update.setStatus(2);
            update.setWarehouseId(request.getWarehouseId());
            update.setPositionId(item.getPositionId());
            update.setPositionNum(item.getPositionNum());
            update.setUpdateBy(userName);
            update.setUpdateTime(new Date());
            inItemService.updateById(update);
        }

        // 查询入库表单是否入库完成
        List<ErpStockInItem> itemList = inItemService.list(new LambdaQueryWrapper<ErpStockInItem>().eq(ErpStockInItem::getStockInId, erpStockIn.getId()).ne(ErpStockInItem::getStatus, 2));
        ErpStockIn sUpdate = new ErpStockIn();
        if (itemList.isEmpty()) {
            // 全部入库完成了
            sUpdate.setStatus(2);
        } else {
            // 部分入库
            sUpdate.setStatus(1);
        }
        sUpdate.setId(erpStockIn.getId());
        sUpdate.setStockInOperatorId(tenantId.toString());
        sUpdate.setStockInOperator(request.getStockInOperator());
        sUpdate.setStockInTime(new Date());
        sUpdate.setUpdateBy(userName);
        sUpdate.setUpdateTime(new Date());
        mapper.updateById(sUpdate);


        return ResultVo.success();
    }

    @Override
    public ErpStockIn getDetailAndItemById(Long id) {
        ErpStockIn erpStockIn = mapper.selectById(id);
        if(erpStockIn !=null){
            erpStockIn.setItemList(inItemService.list(new LambdaQueryWrapper<ErpStockInItem>().eq(ErpStockInItem::getStockInId,id)));
            return erpStockIn;
        }else
            return null;
    }
}




