package cn.qihangerp.api.service;

import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpGoods;
import cn.qihangerp.api.domain.vo.GoodsSpecListVo;
import com.baomidou.mybatisplus.extension.service.IService;
import cn.qihangerp.api.domain.ErpGoodsSku;

import java.util.List;

/**
* @author TW
* @description 针对表【erp_goods(商品库存管理)】的数据库操作Service
* @createDate 2024-04-12 14:52:05
*/
public interface ErpGoodsService extends IService<ErpGoods> {
    PageResult<ErpGoods> queryPageList(ErpGoods bo, PageQuery pageQuery);
    PageResult<ErpGoodsSku> querySkuPageList(ErpGoodsSku bo, PageQuery pageQuery);
    int insertGoods(ErpGoods goods);
    int deleteGoods(Long[] ids);

    /**
     * 根据SKU编码搜索商品
     * @param keyword
     * @return
     */
    List<GoodsSpecListVo> searchGoodsSpec(Long tenantId,Long supplierId,String keyword);
}
