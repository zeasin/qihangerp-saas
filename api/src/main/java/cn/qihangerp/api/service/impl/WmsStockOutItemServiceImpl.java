package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.utils.StringUtils;
import cn.qihangerp.api.domain.WmsStockOutItem;
import cn.qihangerp.api.mapper.WmsStockOutItemMapper;
import cn.qihangerp.api.request.ShopDailyRequest;
import cn.qihangerp.api.service.WmsStockOutItemService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
* @author qilip
* @description 针对表【wms_stock_out_item(出库单明细)】的数据库操作Service实现
* @createDate 2024-09-22 11:13:23
*/
@AllArgsConstructor
@Service
public class WmsStockOutItemServiceImpl extends ServiceImpl<WmsStockOutItemMapper, WmsStockOutItem>
    implements WmsStockOutItemService {
    private final WmsStockOutItemMapper outItemMapper;


    @Override
    public List<WmsStockOutItem> searchList(ShopDailyRequest request) {
        // 定义日期格式
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String startDate = LocalDate.now().minusDays(1).format(formatter);
        String endDate = startDate;
        // 日期处理
        if (request.getDates() != null) {
            if (request.getDates().length > 1) {
                startDate = request.getDates()[0];
                endDate = request.getDates()[1];
                ;
            } else if (request.getDates().length > 0) {
                startDate = request.getDates()[0];
                endDate = startDate;
            }
        }


        LambdaQueryWrapper<WmsStockOutItem> qw = new LambdaQueryWrapper<>();
        qw.ge(WmsStockOutItem::getCompleteTime, startDate + " 00:00:00");
        qw.le(WmsStockOutItem::getCompleteTime, endDate + " 23:59:59");
        qw.eq(StringUtils.isNotEmpty(request.getSkuCode()),WmsStockOutItem::getSkuCode,request.getSkuCode());
        qw.eq(request.getShopId() != null, WmsStockOutItem::getShopId, request.getShopId());
        qw.eq(request.getShopGroupId() != null, WmsStockOutItem::getShopGroupId, request.getShopGroupId());


        qw.last("order by complete_time desc,id desc");
        List<WmsStockOutItem> list = outItemMapper.selectList(qw);
        return list;
    }

}




