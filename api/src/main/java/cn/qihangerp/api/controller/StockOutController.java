package cn.qihangerp.api.controller;

import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.WmsStockOut;
import cn.qihangerp.api.request.StockOutCreateRequest;
import cn.qihangerp.api.request.StockOutItemRequest;
import cn.qihangerp.api.service.WmsStockOutService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

@AllArgsConstructor
@RestController
@RequestMapping("/stockOut")
public class StockOutController extends BaseController {
    private final WmsStockOutService stockOutService;

    @GetMapping("/list")
    public TableDataInfo list(WmsStockOut bo, PageQuery pageQuery)
    {
        bo.setTenantId(getUserId());
        var pageList = stockOutService.queryPageList(bo,pageQuery);
        return getDataTable(pageList);
    }



    @PostMapping("/create")
    public AjaxResult createEntry(@RequestBody StockOutCreateRequest request)
    {
        ResultVo<Long> resultVo = stockOutService.createEntry(getUserId(), getUsername(), request);
        if(resultVo.getCode()==0)
            return AjaxResult.success();
        else return AjaxResult.error(resultVo.getMsg());
    }

    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
//        WmsStockIn entry = stockInService.getDetailAndItemById(id);
        WmsStockOut entry = stockOutService.getDetailAndItemById(id);
        return success(entry);
    }
    @PostMapping("/out")
    public AjaxResult out(@RequestBody StockOutItemRequest request)
    {
        ResultVo<Long> resultVo = stockOutService.stockOut(getUserId(), getUsername(), request);
        if(resultVo.getCode()==0)
            return AjaxResult.success();
        else return AjaxResult.error(resultVo.getMsg());
    }
}
