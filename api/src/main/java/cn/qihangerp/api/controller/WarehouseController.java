package cn.qihangerp.api.controller;

import cn.qihangerp.api.common.AjaxResult;
import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.common.TableDataInfo;
import cn.qihangerp.api.domain.WmsWarehouse;
import cn.qihangerp.api.domain.WmsWarehousePosition;
import cn.qihangerp.api.service.WmsWarehousePositionService;
import cn.qihangerp.api.service.WmsWarehouseService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping("/warehouse")
public class WarehouseController extends BaseController {
    private final WmsWarehouseService warehouseService;
    private final WmsWarehousePositionService positionService;
    @GetMapping("/list")
    public TableDataInfo list(WmsWarehouse bo)
    {
        LambdaQueryWrapper<WmsWarehouse> qw = new LambdaQueryWrapper<WmsWarehouse>()
                .eq(WmsWarehouse::getTenantId,getUserId())
                .eq(bo.getStatus()!=null,WmsWarehouse::getStatus, bo.getStatus())
                .like(StringUtils.hasText(bo.getNumber()),WmsWarehouse::getNumber,bo.getNumber())
                .like(StringUtils.hasText(bo.getName()),WmsWarehouse::getName,bo.getName())
                ;
        List<WmsWarehouse> wmsWarehouses = warehouseService.list(qw);
        return getDataTable(wmsWarehouses);
    }

    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(warehouseService.getById(id));
    }
    @PostMapping
    public AjaxResult add(@RequestBody WmsWarehouse warehouse, HttpServletRequest request)
    {
        warehouse.setTenantId(getUserId());
        warehouse.setCreateBy(getUsername());
        warehouse.setCreateTime(new Date());
        boolean save = warehouseService.save(warehouse);
        if(save){
            WmsWarehousePosition position = new WmsWarehousePosition();
            position.setTenantId(getUserId());
            position.setWarehouseId(warehouse.getId());
            position.setParentId(0);
            position.setParentId1(0);
            position.setParentId2(0);
            position.setNumber(warehouse.getNumber());
            position.setName(warehouse.getName());
            position.setIsDelete(0);
            position.setAddress(warehouse.getAddress());
            position.setRemark(warehouse.getRemark());
            position.setCreateBy(getUsername());
            position.setCreateTime(new Date());
            positionService.save(position);
        }
        return AjaxResult.success();
    }
    @PutMapping
    public AjaxResult edit(@RequestBody WmsWarehouse warehouse, HttpServletRequest request)
    {
        warehouse.setTenantId(null);
        warehouse.setUpdateBy(getUsername());
        warehouse.setUpdateTime(new Date());
        return toAjax(warehouseService.updateById(warehouse));
    }
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(warehouseService.removeBatchByIds(Arrays.stream(ids).toList()));
    }

    @GetMapping("/position/list")
    public TableDataInfo positionList(Long warehouseId)
    {
        LambdaQueryWrapper<WmsWarehousePosition> qw = new LambdaQueryWrapper<WmsWarehousePosition>()
                .eq(WmsWarehousePosition::getTenantId,getUserId())
                .eq(WmsWarehousePosition::getWarehouseId,warehouseId)
                ;
        List<WmsWarehousePosition> list = positionService.list(qw);
        return getDataTable(list);
    }
    @GetMapping("/position/search")
    public TableDataInfo searchPosition(Long warehouseId,String number)
    {
        LambdaQueryWrapper<WmsWarehousePosition> qw = new LambdaQueryWrapper<WmsWarehousePosition>()
                .eq(WmsWarehousePosition::getTenantId,getUserId())
                .eq(warehouseId!=null,WmsWarehousePosition::getWarehouseId,warehouseId)
                .like(WmsWarehousePosition::getNumber,number)
                ;
        List<WmsWarehousePosition> list = positionService.list(qw);
        return getDataTable(list);
    }


    @PostMapping("/position")
    public AjaxResult positionAdd(@RequestBody WmsWarehousePosition position, HttpServletRequest request) {
        position.setTenantId(getUserId());
        position.setCreateBy(getUsername());
        position.setCreateTime(new Date());
        position.setParentId1(0);
        position.setParentId2(0);
        positionService.save(position);

        return AjaxResult.success();
    }

    @GetMapping(value = "/position/{id}")
    public AjaxResult getPositionInfo(@PathVariable("id") Long id)
    {
        return success(positionService.getById(id));
    }

    @PutMapping("/position")
    public AjaxResult positionEdit(@RequestBody WmsWarehousePosition position, HttpServletRequest request)
    {
        position.setTenantId(getUserId());
        position.setUpdateBy(getUsername());
        position.setUpdateTime(new Date());
        return toAjax(positionService.updateById(position));
    }
    @DeleteMapping("/position/{ids}")
    public AjaxResult positionRemove(@PathVariable Long[] ids)
    {
        return toAjax(positionService.removeBatchByIds(Arrays.stream(ids).toList()));
    }


}
