package cn.qihangerp.api.controller.sys;

import cn.qihangerp.api.common.security.LoginUser;
import cn.qihangerp.api.common.security.TokenService;
import cn.qihangerp.api.common.utils.IpUtils;
import cn.qihangerp.api.request.SingOnReq;
import cn.qihangerp.api.service.ISysUserService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import cn.qihangerp.api.common.AjaxResult;
import cn.qihangerp.api.common.constant.Constants;
import cn.qihangerp.api.common.security.SecurityUtils;
import cn.qihangerp.api.domain.SysMenu;
import cn.qihangerp.api.domain.SysUser;
import cn.qihangerp.api.domain.bo.LoginBody;
import cn.qihangerp.api.service.ISysMenuService;
import cn.qihangerp.api.service.SysLoginService;
import cn.qihangerp.api.service.SysPermissionService;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * 登录验证
 * 
 * @author qihang
 */
@AllArgsConstructor
@RestController
public class SysLoginController
{
    private final SysLoginService loginService;

    private final ISysMenuService menuService;

    private final SysPermissionService permissionService;

    private final ISysUserService userService;

    private final TokenService tokenService;

    /**
     * 登录方法
     * 
     * @param loginBody 登录信息
     * @return 结果
     */
    @PostMapping("/login")
    public AjaxResult login(@RequestBody LoginBody loginBody, HttpServletRequest request) {
        try {
            SysUser sysUser = userService.selectUserByUserName(loginBody.getUsername());
            AjaxResult ajax = AjaxResult.success();
            // 生成令牌
            String token = loginService.login(loginBody.getUsername(), loginBody.getPassword(), loginBody.getCode(), loginBody.getUuid());
//            String token = loginService.login(loginBody.getUsername(), sysUser.getPassword(), loginBody.getCode(), loginBody.getUuid());


//            LoginUser loginUser = new LoginUser();
//            loginUser.setUser(sysUser);
//            loginUser.setUserId(sysUser.getUserId());
//            loginUser.setLoginLocation("");
//            loginUser.setLoginTime(System.currentTimeMillis()/1000);
//            loginUser.setDeptId(sysUser.getDeptId());
//            loginUser.setIpaddr(IpUtils.getIpAddr(request));
//            String token = tokenService.createToken(loginUser);
            ajax.put(Constants.TOKEN, token);
            return ajax;
        } catch (Exception e) {
            return AjaxResult.error(e.getMessage());
        }
    }

    @PostMapping("/signOn")
    public AjaxResult singOn(@RequestBody SingOnReq loginBody) {
        SysUser sysUser = new SysUser();
        sysUser.setUserName(loginBody.getPhone());
        if (!userService.checkUserNameUnique(sysUser))
        {
            return AjaxResult.error("注册失败，账号已存在");
        }
        sysUser.setNickName("试用会员"+loginBody.getPhone().substring(7));
        sysUser.setCreateBy("主动注册");
        sysUser.setPassword(SecurityUtils.encryptPassword(loginBody.getPasswords()));
        //试用期一个月
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String expirationDate = LocalDate.now().plusMonths(1L).format(formatter);
        sysUser.setExpirationDate(expirationDate);
        sysUser.setCreateTime(new Date());
        sysUser.setUpdateTime(new Date());
        userService.insertUser(sysUser);
        try {
            AjaxResult ajax = AjaxResult.success();
            // 生成令牌
            String token = loginService.login(loginBody.getPhone(), loginBody.getPasswords(), "", null);
            ajax.put(Constants.TOKEN, token);
            return ajax;
        } catch (Exception e) {
            return AjaxResult.error(1500, e.getMessage());
        }
    }

    /**
     * 获取用户信息
     * 
     * @return 用户信息
     */
    @GetMapping("getInfo")
    public AjaxResult getInfo()
    {
        SysUser user = SecurityUtils.getLoginUser().getUser();
        // 角色集合
        Set<String> roles = permissionService.getRolePermission(user);
        // 权限集合
        Set<String> permissions = permissionService.getMenuPermission(user);
        AjaxResult ajax = AjaxResult.success();
        ajax.put("user", user);
        ajax.put("roles", roles);
        ajax.put("permissions", permissions);
        return ajax;
    }

    /**
     * 获取路由信息
     * 
     * @return 路由信息
     */
    @GetMapping("getRouters")
    public AjaxResult getRouters()
    {
        Long userId = SecurityUtils.getUserId();
        List<SysMenu> menus = menuService.selectMenuTreeByUserId(userId);
        return AjaxResult.success(menuService.buildMenus(menus));
    }
}
