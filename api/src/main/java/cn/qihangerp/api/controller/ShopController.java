package cn.qihangerp.api.controller;

import cn.qihangerp.api.domain.Shop;
import cn.qihangerp.api.service.ShopService;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.AjaxResult;
import cn.qihangerp.api.common.BaseController;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.common.TableDataInfo;
import cn.qihangerp.api.domain.SysLogisticsCompany;
import cn.qihangerp.api.domain.SysPlatform;
import cn.qihangerp.api.service.SysLogisticsCompanyService;
import java.util.List;

/**
 * 店铺Controller
 * 
 * @author qihang
 * @date 2023-12-31
 */
@AllArgsConstructor
@RestController
@RequestMapping("/shop")
public class ShopController extends BaseController {
    private final SysLogisticsCompanyService logisticsCompanyService;
    private final ShopService shopService;

    /**
     * 查询店铺列表logistics
     */
    @PreAuthorize("@ss.hasPermi('shop:shop:list')")
    @GetMapping("/list")
    public TableDataInfo list(Shop shop)
    {
        shop.setTenantId(getUserId());
        List<Shop> list = shopService.selectShopList(shop);
        return getDataTable(list);
    }

    /**
     * 获取店铺详细信息
     */
    @PreAuthorize("@ss.hasPermi('shop:shop:query')")
    @GetMapping(value = "/shop/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(shopService.getById(id));
    }

    /**
     * 新增店铺
     */
    @PreAuthorize("@ss.hasPermi('shop:shop:add')")
    @PostMapping("/shop")
    public AjaxResult add(@RequestBody Shop shop)
    {
        shop.setTenantId(getUserId());
        shop.setType(5);
        shop.setModifyOn(System.currentTimeMillis()/1000);
        return toAjax(shopService.save(shop));
    }

    /**
     * 修改店铺
     */
    @PreAuthorize("@ss.hasPermi('shop:shop:edit')")
    @PutMapping("/shop")
    public AjaxResult edit(@RequestBody Shop shop)
    {
        shop.setTenantId(null);
        shop.setModifyOn(System.currentTimeMillis()/1000);
        return toAjax(shopService.updateById(shop));
    }


    /**
     * 删除店铺
     */
    @PreAuthorize("@ss.hasPermi('shop:shop:remove')")
	@DeleteMapping("/shop/{id}")
    public AjaxResult remove(@PathVariable Long id)
    {
        return toAjax(shopService.removeById(id));
    }

//    /**
//     * 查询店铺列表logistics
//     */
//    @GetMapping("/logistics")
//    public TableDataInfo logisticsList(Integer platform, Integer shopId, PageQuery pageQuery)
//    {
//        PageResult<SysLogisticsCompany> result = logisticsCompanyService.queryPageList(platform, shopId, pageQuery);
//        return getDataTable(result);
//    }
}
