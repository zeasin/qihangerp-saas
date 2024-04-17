package cn.qihangerp.api.controller;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.TableDataInfo;
import cn.qihangerp.api.domain.ErpGoods;
import cn.qihangerp.api.domain.ErpSupplier;
import cn.qihangerp.api.service.ErpSupplierService;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping("/supplier")
public class SupplierController extends BaseController{
    private final ErpSupplierService supplierService;

    @GetMapping("/list")
    public TableDataInfo list(ErpSupplier bo, PageQuery pageQuery)
    {
        PageResult<ErpSupplier> pageResult = supplierService.queryPageList(bo, pageQuery);
        return getDataTable(pageResult);
    }

    @GetMapping("/list_all")
    public TableDataInfo listAll()
    {
        List<ErpSupplier> list = supplierService.list();
        return getDataTable(list);
    }
}
