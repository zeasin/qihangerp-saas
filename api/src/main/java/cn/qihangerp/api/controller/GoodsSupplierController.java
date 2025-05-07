package cn.qihangerp.api.controller;

import cn.qihangerp.api.common.*;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import cn.qihangerp.api.domain.ErpSupplier;
import cn.qihangerp.api.service.ErpSupplierService;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping("/supplier")
public class GoodsSupplierController extends BaseController{
    private final ErpSupplierService supplierService;

    @GetMapping("/list")
    public TableDataInfo list(ErpSupplier bo, PageQuery pageQuery)
    {
        if(getUserId()!=1) {
            bo.setTenantId(getUserId());
        }
        PageResult<ErpSupplier> pageResult = supplierService.queryPageList(bo, pageQuery);
        return getDataTable(pageResult);
    }

    @GetMapping("/list_all")
    public TableDataInfo listAll()
    {
        List<ErpSupplier> list = supplierService.list(new LambdaQueryWrapper<ErpSupplier>().eq(ErpSupplier::getTenantId,getUserId()));
        return getDataTable(list);
    }

    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(supplierService.getById(id));
    }


    /**
     * 新增
     */
    @PostMapping
    public AjaxResult add(@RequestBody ErpSupplier bo)
    {
        if(getUserId()==1) {
            return AjaxResult.error("超级管理员账号不允许操作");
        }
        bo.setTenantId(getUserId());
        bo.setCreateBy("手动添加");
        bo.setCreateTime(new Date());
        return toAjax(supplierService.save(bo));
    }

    @PutMapping
    public AjaxResult edit(@RequestBody ErpSupplier bo)
    {
        if(getUserId()==1) {
            return AjaxResult.error("超级管理员账号不允许操作");
        }
        bo.setTenantId(null);
        bo.setCreateTime(null);
        bo.setCreateBy(null);
        bo.setUpdateBy("手动更新");
        bo.setUpdateTime(new Date());
        return toAjax(supplierService.updateById(bo));
    }

    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        if(getUserId()==1) {
            return AjaxResult.error("超级管理员账号不允许操作");
        }
        return toAjax(supplierService.removeBatchByIds(Arrays.stream(ids).toList()));
    }

}
