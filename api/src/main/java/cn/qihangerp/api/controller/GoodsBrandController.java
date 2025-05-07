package cn.qihangerp.api.controller;

import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.ErpGoods;
import cn.qihangerp.api.domain.ErpGoodsBrand;
import cn.qihangerp.api.service.ErpGoodsBrandService;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Date;

@AllArgsConstructor
@RestController
@RequestMapping("/goods/brand")
public class GoodsBrandController extends BaseController {
    private final ErpGoodsBrandService brandService;

    @GetMapping("/list")
    public TableDataInfo list(ErpGoodsBrand bo, PageQuery pageQuery)
    {
        if(getUserId()!=1) {
            bo.setTenantId(getUserId());
        }
        PageResult<ErpGoodsBrand> pageResult = brandService.queryPageList(bo, pageQuery);
        return getDataTable(pageResult);
    }

    /**
     * 新增
     */
    @PostMapping
    public AjaxResult add(@RequestBody ErpGoodsBrand bo)
    {
        if(getUserId()==1) {
            return AjaxResult.error("超级管理员账号不允许操作");
        }
        bo.setTenantId(getUserId());
        bo.setCreateBy("手动添加");
        bo.setCreateTime(new Date());
        return toAjax(brandService.save(bo));
    }

    /**
     * 获取详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(brandService.getById(id));
    }


    /**
     * 修改
     */
    @PutMapping
    public AjaxResult edit(@RequestBody ErpGoodsBrand bo)
    {
        if(getUserId()==1) {
            return AjaxResult.error("超级管理员账号不允许操作");
        }
        bo.setCreateTime(null);
        bo.setCreateBy(null);
        bo.setUpdateBy("手动修改");
        bo.setUpdateTime(new Date());
        bo.setTenantId(null);

        return toAjax(brandService.updateById(bo));
    }

    /**
     * 删除
     */
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        if(getUserId()==1) {
            return AjaxResult.error("超级管理员账号不允许操作");
        }
        return toAjax(brandService.removeBatchByIds(Arrays.stream(ids).toList()));
    }
}
