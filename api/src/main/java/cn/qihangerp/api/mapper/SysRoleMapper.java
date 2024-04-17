package cn.qihangerp.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import cn.qihangerp.api.domain.SysRole;


import java.util.List;

/**
* @author TW
* @description 针对表【sys_role(角色信息表)】的数据库操作Mapper
* @createDate 2024-03-15 16:55:10
* @Entity com.qihang.sys.api.domain.SysRole
*/
public interface SysRoleMapper extends BaseMapper<SysRole> {
    List<SysRole> selectRolePermissionByUserId(Long userId);
    SysRole selectRoleById(Long roleId);
    List<SysRole> selectRoleList(SysRole role);
    List<Long> selectRoleListByUserId(Long userId);
    SysRole checkRoleNameUnique(String roleName);
    SysRole checkRoleKeyUnique(String roleKey);
    int insertRole(SysRole role);
    int updateRole(SysRole role);
    int deleteRoleById(Long roleId);
    int deleteRoleByIds(Long[] roleIds);
}




