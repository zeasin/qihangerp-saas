package cn.qihangerp.api.service.impl;

import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.common.utils.DateUtils;
import cn.qihangerp.api.domain.*;
import cn.qihangerp.api.mapper.*;
import cn.qihangerp.api.request.SupplierAgentShipmentRequest;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.service.ErpShipmentService;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
* @author TW
* @description 针对表【erp_order_shipping(发货记录表)】的数据库操作Service实现
* @createDate 2024-04-03 15:57:41
*/
@AllArgsConstructor
@Service
public class ErpShipmentServiceImpl extends ServiceImpl<ErpShipmentMapper, ErpShipment>
    implements ErpShipmentService {
    private final ErpShipmentMapper mapper;
    private final ErpShipmentItemMapper shipmentItemMapper;
    private final ErpOrderMapper orderMapper;
    private final ErpOrderItemMapper orderItemMapper;
    private final ErpLogisticsCompanyMapper erpLogisticsCompanyMapper;

    @Override
    public PageResult<ErpShipment> queryPageList(ErpShipment shipping, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpShipment> queryWrapper = new LambdaQueryWrapper<ErpShipment>()
                .eq(shipping.getShipper()!=null,ErpShipment::getShipper,shipping.getShipper())
                .eq(ErpShipment::getTenantId,shipping.getTenantId())
                .eq(StringUtils.hasText(shipping.getOrderNum()), ErpShipment::getOrderNum, shipping.getOrderNum())
                .eq(StringUtils.hasText(shipping.getShipCode()), ErpShipment::getShipCode, shipping.getShipCode())
                .eq(shipping.getShopId() != null, ErpShipment::getShopId, shipping.getShopId());

        Page<ErpShipment> pages = mapper.selectPage(pageQuery.build(), queryWrapper);
        if(pages.getRecords().size()>0){
            for(ErpShipment item : pages.getRecords()){
                item.setItemList(shipmentItemMapper.selectList(new LambdaQueryWrapper<ErpShipmentItem>().eq(ErpShipmentItem::getShipmentId,item.getId())));
            }
        }
        return PageResult.build(pages);
    }

    @Override
    public ErpShipment queryDetailById(Long id) {
        ErpShipment erpShipment = mapper.selectById(id);
        if(erpShipment!=null){
            erpShipment.setItemList(shipmentItemMapper.selectList(new LambdaQueryWrapper<ErpShipmentItem>().eq(ErpShipmentItem::getShipmentId,erpShipment.getId())));
        }
        return erpShipment;
    }


}




