package cn.qihangerp.api.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.api.domain.ErpOrderShipList;
import cn.qihangerp.api.service.ErpOrderShipListService;
import cn.qihangerp.api.mapper.ErpOrderShipListMapper;
import org.springframework.stereotype.Service;

/**
* @author qilip
* @description 针对表【erp_order_ship_list(发货-备货表（取号发货加入备货清单、分配供应商发货加入备货清单）)】的数据库操作Service实现
* @createDate 2025-05-24 18:52:58
*/
@Service
public class ErpOrderShipListServiceImpl extends ServiceImpl<ErpOrderShipListMapper, ErpOrderShipList>
    implements ErpOrderShipListService{

}




