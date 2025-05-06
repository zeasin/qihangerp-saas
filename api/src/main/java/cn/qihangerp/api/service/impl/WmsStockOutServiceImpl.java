package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.common.ResultVoEnum;
import cn.qihangerp.api.common.utils.DateUtils;
import cn.qihangerp.api.domain.OGoodsInventory;
import cn.qihangerp.api.domain.OGoodsInventoryBatch;
import cn.qihangerp.api.domain.WmsStockOut;
import cn.qihangerp.api.domain.WmsStockOutItem;
import cn.qihangerp.api.mapper.WmsStockOutMapper;
import cn.qihangerp.api.request.GoodsSkuInventoryVo;
import cn.qihangerp.api.request.StockOutCreateRequest;
import cn.qihangerp.api.request.StockOutItemRequest;
import cn.qihangerp.api.service.OGoodsInventoryBatchService;
import cn.qihangerp.api.service.OGoodsInventoryService;
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
public class WmsStockOutServiceImpl extends ServiceImpl<WmsStockOutMapper, WmsStockOut>
    implements WmsStockOutService {
    private final WmsStockOutMapper outMapper;
    private final WmsStockOutItemService outItemService;
    private final OGoodsInventoryBatchService goodsInventoryBatchService;
    private final OGoodsInventoryService goodsInventoryService;

    @Override
    public PageResult<WmsStockOut> queryPageList(WmsStockOut bo, PageQuery pageQuery) {
        LambdaQueryWrapper<WmsStockOut> queryWrapper = new LambdaQueryWrapper<WmsStockOut>()
                .eq( bo.getShopId()!=null,WmsStockOut::getShopId, bo.getShopId())
                .eq( bo.getShopGroupId()!=null,WmsStockOut::getShopGroupId, bo.getShopGroupId())
                .eq( bo.getStatus()!=null,WmsStockOut::getStatus, bo.getStatus())
                .eq( bo.getType()!=null,WmsStockOut::getType, bo.getType())
                .eq(StringUtils.isNotBlank(bo.getOutNum()),WmsStockOut::getOutNum, bo.getOutNum())
                .eq(StringUtils.isNotBlank(bo.getSourceNum()),WmsStockOut::getSourceNum, bo.getSourceNum())
                .eq(bo.getSourceId()!=null,WmsStockOut::getSourceId, bo.getSourceId())
                ;

        Page<WmsStockOut> pages = outMapper.selectPage(pageQuery.build(), queryWrapper);
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
        WmsStockOut insert = new WmsStockOut();
        insert.setOutNum(request.getOutNum());
        insert.setType(request.getType());
        insert.setShopId(request.getShopId());
        insert.setShopGroupId(request.getShopGroupId());
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
        List<WmsStockOutItem> itemList = new ArrayList<>();
        for(GoodsSkuInventoryVo item: request.getItemList()){
            if(org.springframework.util.StringUtils.hasText(item.getBatchId())) {
                OGoodsInventoryBatch batch = goodsInventoryBatchService.getById(item.getBatchId());
                if(batch!=null) {

                    WmsStockOutItem inItem = new WmsStockOutItem();
                    inItem.setShopId(request.getShopId());
                    inItem.setShopGroupId(request.getShopGroupId());
                    inItem.setEntryId(insert.getId());
                    inItem.setType(request.getType());
                    inItem.setBatchId(batch.getId());
                    inItem.setGoodsId(batch.getGoodsId());
                    inItem.setPurPrice(batch.getPurPrice());
                    inItem.setSkuId(batch.getSkuId());
                    inItem.setSkuCode(batch.getSkuCode());
                    inItem.setGoodsName(item.getGoodsName());
                    inItem.setGoodsNum(item.getGoodsNum());
                    inItem.setSkuName(item.getSkuName());
                    inItem.setGoodsImage(item.getGoodsImg());
                    inItem.setOriginalQuantity(item.getQuantity());
                    inItem.setOutQuantity(0L);
                    inItem.setStatus(0);
                    inItem.setCreateBy(userName);
                    inItem.setCreateTime(new Date());
                    inItem.setWarehouseId(batch.getWarehouseId());
                    inItem.setPositionId(batch.getPositionId());

                    inItem.setPositionNum(batch.getPositionNum());
                    itemList.add(inItem);
                }
            }
        }
        outItemService.saveBatch(itemList);
        return ResultVo.success();
    }

    @Override
    public WmsStockOut getDetailAndItemById(Long id) {
        WmsStockOut wmsStockOut = outMapper.selectById(id);
        if(wmsStockOut!=null){
            wmsStockOut.setItemList(outItemService.list(new LambdaQueryWrapper<WmsStockOutItem>().eq(WmsStockOutItem::getEntryId,id)));
        }
        return wmsStockOut;
    }

    @Transactional
    @Override
    public ResultVo<Long> stockOut(Long userId, String userName, StockOutItemRequest request) {
        if(request.getEntryItemId() == null) return ResultVo.error(1500,"缺少参数：outItemId");
        if(request.getOutQty()==null || request.getOutQty().longValue()<=0) return ResultVo.error(1500,"缺少参数：出库数量");

        WmsStockOutItem outItem = outItemService.getById(request.getEntryItemId());
        if(outItem == null) return ResultVo.error(1500,"出库数据错误");
        // 判断库存够不够扣减的
        OGoodsInventoryBatch batch = goodsInventoryBatchService.getById(outItem.getBatchId());
        if(batch == null) return ResultVo.error(1500,"库存数据不存在");
        if(batch.getCurrentQty().longValue()< request.getOutQty().longValue())
            return ResultVo.error(1500,"库存不足");
        if(StringUtils.isEmpty(batch.getRemark())) batch.setRemark("");
        // 扣减库存
        // 1扣减批次库存
        OGoodsInventoryBatch updateBatch = new OGoodsInventoryBatch();
        updateBatch.setCurrentQty(batch.getCurrentQty() - request.getOutQty());
        updateBatch.setUpdateBy(userName);
        updateBatch.setUpdateTime(new Date());
        updateBatch.setRemark(batch.getRemark()+"出库扣减库存；");
        updateBatch.setId(batch.getId());
        goodsInventoryBatchService.updateById(updateBatch);
        // 2扣减总库存
        OGoodsInventory goodsInventory = goodsInventoryService.getById(batch.getInventoryId());
        OGoodsInventory updateInventory = new OGoodsInventory();
        updateInventory.setId(goodsInventory.getId());
        updateInventory.setQuantity(goodsInventory.getQuantity() - request.getOutQty());
        updateInventory.setUpdateBy(userName);
        updateInventory.setUpdateTime(new Date());
        goodsInventoryService.updateById(updateInventory);
        // 更新自己的状态
        WmsStockOutItem outItemUpdate = new WmsStockOutItem();
        outItemUpdate.setId(outItem.getId());
        outItemUpdate.setStatus(2);
        outItemUpdate.setCompleteTime(new Date());
        outItemUpdate.setOutQuantity(outItem.getOutQuantity()+ request.getOutQty());
        outItemUpdate.setUpdateBy(userName);
        outItemUpdate.setUpdateTime(new Date());
        outItemService.updateById(outItemUpdate);

        // 更新主表单数据
        WmsStockOut wmsStockOut = outMapper.selectById(outItem.getEntryId());
        if(wmsStockOut.getOutTotal()==null)wmsStockOut.setOutTotal(0);
        // 查询入库表单是否入库完成
        List<WmsStockOutItem> itemList = outItemService.list(new LambdaQueryWrapper<WmsStockOutItem>().eq(WmsStockOutItem::getEntryId,outItem.getEntryId()).ne(WmsStockOutItem::getStatus, 2));
        WmsStockOut sUpdate = new WmsStockOut();
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
        sUpdate.setOutTotal(wmsStockOut.getOutTotal()+request.getOutQty().intValue());
        sUpdate.setUpdateBy(userName);
        sUpdate.setUpdateTime(new Date());
        outMapper.updateById(sUpdate);

        return ResultVo.success();
    }
}




