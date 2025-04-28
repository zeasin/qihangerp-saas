package cn.qihangerp.api.common.security;

import cn.qihangerp.api.common.utils.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import cn.qihangerp.api.common.enums.UserStatus;
import cn.qihangerp.api.common.exception.ServiceException;
import cn.qihangerp.api.common.utils.MessageUtils;
import cn.qihangerp.api.common.utils.StringUtils;
import cn.qihangerp.api.domain.SysUser;
import cn.qihangerp.api.service.ISysUserService;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * 用户验证处理
 *
 * @author qihang
 */
@Service
public class UserDetailsServiceImpl implements UserDetailsService
{
    private static final Logger log = LoggerFactory.getLogger(UserDetailsServiceImpl.class);

    @Autowired
    private ISysUserService userService;

    @Autowired
    private SysPasswordService passwordService;

//    @Autowired
//    private SysPermissionService permissionService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException
    {
        SysUser user = userService.selectUserByUserName(username);
        if (StringUtils.isNull(user))
        {
            log.info("登录用户：{} 不存在.", username);
            throw new ServiceException(MessageUtils.message("user.not.exists"));
        }
        else if (UserStatus.DELETED.getCode().equals(user.getDelFlag()))
        {
            log.info("登录用户：{} 已被删除.", username);
            throw new ServiceException(MessageUtils.message("user.password.delete"));
        }
        else if (UserStatus.DISABLE.getCode().equals(user.getStatus()))
        {
            log.info("登录用户：{} 已被停用.", username);
            throw new ServiceException(MessageUtils.message("user.blocked"));
        }
        if(user==null||user.getExpirationDate()==null){
            log.info("登录用户：{} 已过期.", username);
            throw new ServiceException(MessageUtils.message("user.expiration"));
        }else{
            if(user.getUserId()!=1) {
                Date expirationDate = DateUtils.dateTime("yyyy-MM-dd", user.getExpirationDate());
                if (expirationDate.before(new Date())) {
                    log.info("登录用户：{} 已过期.", username);
                    throw new ServiceException(MessageUtils.message("user.expiration"));
                }
            }
        }
//        Authentication usernamePasswordAuthenticationToken = AuthenticationContextHolder.getContext();
//        String password = usernamePasswordAuthenticationToken.getCredentials().toString();
//        if(!password.equals(user.getPassword())) {
            passwordService.validate(user);
//        }

        return createLoginUser(user);
    }

    public UserDetails createLoginUser(SysUser user)
    {
        Set<String> perms = new HashSet<String>();
        perms.add("*:*:*");
//        return new LoginUser(user.getUserId(), user.getDeptId(), user, permissionService.getMenuPermission(user));
        return new LoginUser(user.getUserId(), user.getDeptId(), user, perms);
    }
}
