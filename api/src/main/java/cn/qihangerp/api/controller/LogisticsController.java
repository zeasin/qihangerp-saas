package cn.qihangerp.api.controller;

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
    public TableDataInfo logisticsList(PageQuery pageQuery)
    {
        PageResult<ErpLogisticsCompany> result = erpLogisticsCompanyService.queryPageList(getUserId(),null, null, pageQuery);
        return getDataTable(result);
    }
    @GetMapping("/logistics/status_list")
    public TableDataInfo logisticsStatusList(Integer status, Integer shopId)
    {
        if(status == null) status=1;
        return getDataTable(erpLogisticsCompanyService.queryListByStatus(getUserId(),status, shopId));
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

}
