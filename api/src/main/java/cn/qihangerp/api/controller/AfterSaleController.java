package cn.qihangerp.api.controller;

import cn.qihangerp.api.domain.ShopRefund;
import cn.qihangerp.api.service.ShopRefundService;
import lombok.AllArgsConstructor;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import cn.qihangerp.api.common.*;
import cn.qihangerp.api.domain.ErpOrderAfterSale;
import cn.qihangerp.api.service.ErpOrderAfterSaleService;
import java.util.Date;

@AllArgsConstructor
@RestController
@RequestMapping("/afterSale")
public class AfterSaleController extends BaseController {
    private final ErpOrderAfterSaleService afterSaleService;
    private final ShopRefundService shopRefundService;
    /**
     * 查询列表
     */
    @GetMapping("/ship_again_list")
    public TableDataInfo ship_again_list(ErpOrderAfterSale bo, PageQuery pageQuery)
    {
        bo.setType(80);
        PageResult<ErpOrderAfterSale> result = afterSaleService.queryPageList(bo, pageQuery);
        return getDataTable(result);
    }

    @PostMapping("/shipAgain")
    public AjaxResult shipAgainAdd(@RequestBody ErpOrderAfterSale addBo)
    {
        addBo.setType(80);
        addBo.setCreateTime(new Date());
        addBo.setCreateBy("手动添加");
        addBo.setStatus(1);
        var result = afterSaleService.save(addBo);
        return toAjax(result);
    }

    @PutMapping("/shipAgain/complete/{id}")
    public AjaxResult completeShipAgain(@PathVariable Long id)
    {
        ErpOrderAfterSale complete = new ErpOrderAfterSale();
        complete.setId(id.toString());
        complete.setStatus(2);
        complete.setUpdateTime(new Date());
        complete.setUpdateBy("手动完成");
        afterSaleService.updateById(complete);
        return toAjax(1);
    }

    /**
     * 退货列表
     * @param bo
     * @param pageQuery
     * @return
     */
    @GetMapping("/returned_list")
    public TableDataInfo returned_list(ErpOrderAfterSale bo, PageQuery pageQuery)
    {
        bo.setType(10);
        PageResult<ErpOrderAfterSale> result = afterSaleService.queryPageList(bo, pageQuery);
        return getDataTable(result);
    }

    @PostMapping("/returned/updateUserWaybill")
    public AjaxResult updateReturnedWaybill(@RequestBody ErpOrderAfterSale bo){
        if(StringUtils.isEmpty(bo.getId())){
            return AjaxResult.error("缺少参数ID");
        }
        ErpOrderAfterSale orderAfterSale = afterSaleService.getById(bo.getId());
        if(orderAfterSale==null){
            return AjaxResult.error("没有找到数据");
        }
        ShopRefund shopRefund = shopRefundService.getRefundBy(orderAfterSale.getAfterSaleOrderId());
        if(shopRefund==null){
            return AjaxResult.error("数据错误");
        }
        if(shopRefund.getUserShippingStatus()==0){
            return AjaxResult.error("用户还未发回商品");
        }else{
            ErpOrderAfterSale updateBo = new ErpOrderAfterSale();
            updateBo.setId(bo.getId());
            updateBo.setUpdateTime(new Date());
            updateBo.setUpdateBy("手动更新用户发回物流");
            updateBo.setStatus(1);
            updateBo.setReturnWaybillCode(shopRefund.getReturnWaybillId());
            updateBo.setReturnCompany(shopRefund.getReturnDeliveryName());
            afterSaleService.updateById(updateBo);
            return AjaxResult.success();
        }
    }

    @GetMapping("/exchange_list")
    public TableDataInfo exchange_list(ErpOrderAfterSale bo, PageQuery pageQuery)
    {
        bo.setType(20);
        PageResult<ErpOrderAfterSale> result = afterSaleService.queryPageList(bo, pageQuery);
        return getDataTable(result);
    }

    @PostMapping("/exchange")
    public AjaxResult exchangeAdd(@RequestBody ErpOrderAfterSale addBo)
    {
        addBo.setType(20);
        addBo.setCreateTime(new Date());
        addBo.setCreateBy("手动添加");
        addBo.setStatus(1);
        var result = afterSaleService.save(addBo);
        return toAjax(result);
    }

    @GetMapping("/intercept_list")
    public TableDataInfo intercept_list(ErpOrderAfterSale bo, PageQuery pageQuery)
    {
        bo.setType(99);
        PageResult<ErpOrderAfterSale> result = afterSaleService.queryPageList(bo, pageQuery);
        return getDataTable(result);
    }

    /**
     * 详情
     * @param id
     * @return
     */
    @GetMapping("/detail/{id}")
    public AjaxResult detail(@PathVariable Long id){
        return AjaxResult.success(afterSaleService.getById(id));
    }

}
