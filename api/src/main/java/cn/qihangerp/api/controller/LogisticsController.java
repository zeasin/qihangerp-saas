package cn.qihangerp.api.controller;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.LogisticsCompany;
import cn.qihangerp.api.service.LogisticsCompanyService;

@AllArgsConstructor
@RestController
@RequestMapping("/shipping")
public class LogisticsController extends BaseController {
    private final LogisticsCompanyService logisticsCompanyService;
    /**
     * 查询店铺列表logistics
     */
    @GetMapping("/logistics/list")
    public TableDataInfo logisticsList(PageQuery pageQuery)
    {
        PageResult<LogisticsCompany> result = logisticsCompanyService.queryPageList(getUserId(),null, null, pageQuery);
        return getDataTable(result);
    }
    @GetMapping("/logistics/status_list")
    public TableDataInfo logisticsStatusList(Integer status, Integer shopId)
    {
        return getDataTable(logisticsCompanyService.queryListByStatus(status, shopId));
    }
    @PutMapping("/logistics/updateStatus")
    public AjaxResult logisticsUpdateStatus(@RequestBody LogisticsCompany company)
    {
        Integer newStatus = null;
        if(company.getStatus()==null || company.getStatus().intValue() ==0){
            newStatus = 1;
        }else{
            newStatus = 0;
        }
        return toAjax(logisticsCompanyService.updateStatus(company.getId(),newStatus));
    }

    @PostMapping("/logistics/add")
    public AjaxResult add(@RequestBody LogisticsCompany company)
    {
        company.setTenantId(getUserId());
        return toAjax(logisticsCompanyService.save(company));
    }

}
