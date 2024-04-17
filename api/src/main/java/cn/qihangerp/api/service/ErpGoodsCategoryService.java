package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpGoods;
import cn.qihangerp.api.domain.ErpGoodsCategory;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author TW
* @description 针对表【erp_goods_category】的数据库操作Service
* @createDate 2024-04-12 15:01:52
*/

public interface ErpGoodsCategoryService extends IService<ErpGoodsCategory> {
    PageResult<ErpGoodsCategory> queryPageList(ErpGoodsCategory bo, PageQuery pageQuery);
}
