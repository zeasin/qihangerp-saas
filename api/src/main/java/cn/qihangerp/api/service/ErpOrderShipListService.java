package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpOrderShipList;
import cn.qihangerp.api.domain.ErpShipment;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【erp_order_ship_list(发货-备货表（取号发货加入备货清单、分配供应商发货加入备货清单）)】的数据库操作Service
* @createDate 2025-05-24 18:52:58
*/
public interface ErpOrderShipListService extends IService<ErpOrderShipList> {
    PageResult<ErpOrderShipList> queryPageList(ErpOrderShipList shipping, PageQuery pageQuery);
    ErpOrderShipList queryDetailById(Long id);
}
