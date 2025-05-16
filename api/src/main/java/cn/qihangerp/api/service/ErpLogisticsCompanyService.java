package cn.qihangerp.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.ErpLogisticsCompany;

import java.util.List;


/**
* @author TW
* @description 针对表【sys_logistics_company(平台快递公司表)】的数据库操作Service
* @createDate 2024-03-22 11:03:11
*/
public interface ErpLogisticsCompanyService extends IService<ErpLogisticsCompany> {
    PageResult<ErpLogisticsCompany> queryPageList(Long tenantId, Integer platform, Integer shopId, PageQuery pageQuery);
    List<ErpLogisticsCompany> queryListByStatus(Long tenantId, Integer status, Integer shopId);
    int updateStatus(String id,Integer status);
}
