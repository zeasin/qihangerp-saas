package cn.qihangerp.api.service;

import cn.qihangerp.api.domain.WmsStockOutItem;
import cn.qihangerp.api.request.ShopDailyRequest;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author qilip
* @description 针对表【wms_stock_out_item(出库单明细)】的数据库操作Service
* @createDate 2024-09-22 11:13:23
*/
public interface WmsStockOutItemService extends IService<WmsStockOutItem> {
    List<WmsStockOutItem> searchList(ShopDailyRequest request);
}
