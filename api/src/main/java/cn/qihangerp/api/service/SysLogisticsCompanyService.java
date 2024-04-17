package cn.qihangerp.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import cn.qihangerp.api.common.PageQuery;
import cn.qihangerp.api.common.PageResult;
import cn.qihangerp.api.domain.SysLogisticsCompany;

import java.util.List;


/**
* @author TW
* @description 针对表【sys_logistics_company(平台快递公司表)】的数据库操作Service
* @createDate 2024-03-22 11:03:11
*/
public interface SysLogisticsCompanyService extends IService<SysLogisticsCompany> {
    PageResult<SysLogisticsCompany> queryPageList(Integer platform, Integer shopId, PageQuery pageQuery);
    List<SysLogisticsCompany> queryListByStatus(Integer status, Integer shopId);
    int updateStatus(String id,Integer status);
}
