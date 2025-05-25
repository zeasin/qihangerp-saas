package cn.qihangerp.api.controller;

import cn.qihangerp.api.domain.Shop;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.ErpLogisticsCompany;
import cn.qihangerp.api.service.ErpLogisticsCompanyService;

@AllArgsConstructor
@RestController
@RequestMapping("/shipping")
public class LogisticsController extends BaseController {
    private final ErpLogisticsCompanyService erpLogisticsCompanyService;
    /**
     * 查询店铺列表logistics
     */
    @GetMapping("/logistics/list")
    public TableDataInfo logisticsList(Integer platformId,String name,Integer status,PageQuery pageQuery)
    {
        PageResult<ErpLogisticsCompany> result = erpLogisticsCompanyService.queryPageList(getUserId(),platformId, status,name, pageQuery);
        return getDataTable(result);
    }
    @GetMapping(value = "/logistics/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(erpLogisticsCompanyService.getById(id));
    }

    @GetMapping("/logistics/status_list")
    public TableDataInfo logisticsStatusList(Integer status, Integer shopType)
    {
        if(status == null) status=1;
        return getDataTable(erpLogisticsCompanyService.queryListByStatus(getUserId(),status, shopType));
    }
    @PutMapping("/logistics/updateStatus")
    public AjaxResult logisticsUpdateStatus(@RequestBody ErpLogisticsCompany company)
    {
        Integer newStatus = null;
        if(company.getStatus()==null || company.getStatus().intValue() ==0){
            newStatus = 1;
        }else{
            newStatus = 0;
        }
        return toAjax(erpLogisticsCompanyService.updateStatus(company.getId(),newStatus));
    }

    @PostMapping("/logistics/add")
    public AjaxResult add(@RequestBody ErpLogisticsCompany company)
    {
        company.setTenantId(getUserId());
        return toAjax(erpLogisticsCompanyService.save(company));
    }
    @PutMapping("/logistics/edit")
    public AjaxResult edit(@RequestBody ErpLogisticsCompany company)
    {
        company.setTenantId(getUserId());
        erpLogisticsCompanyService.updateById(company);

        return AjaxResult.success();
    }
    @DeleteMapping("/logistics/del/{id}")
    public AjaxResult remove(@PathVariable Long id)
    {
        ErpLogisticsCompany shopInfo = erpLogisticsCompanyService.getById(id);
        if(shopInfo.getTenantId()!=getUserId()){
            return AjaxResult.error("不允许删除别人的店铺");
        }else {
            return toAjax(erpLogisticsCompanyService.removeById(id));
        }
    }


}
