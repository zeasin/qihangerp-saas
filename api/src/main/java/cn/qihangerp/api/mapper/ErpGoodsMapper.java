package cn.qihangerp.api.mapper;

import cn.qihangerp.api.domain.ErpGoods;
import cn.qihangerp.api.domain.vo.GoodsSpecListVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* @author TW
* @description 针对表【erp_goods(商品库存管理)】的数据库操作Mapper
* @createDate 2024-04-12 14:52:05
* @Entity cn.qihangerp.api.domain.ErpGoods
*/
public interface ErpGoodsMapper extends BaseMapper<ErpGoods> {
    List<GoodsSpecListVo> searchGoodsSpec(Long tenantId,Long supplierId,String keyword);
}




