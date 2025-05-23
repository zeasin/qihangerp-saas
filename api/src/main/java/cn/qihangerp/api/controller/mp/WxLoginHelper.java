package cn.qihangerp.api.controller.mp;


import cn.qihangerp.api.common.cache.RedisCache;
import cn.qihangerp.api.common.exception.NoVlaInGuavaException;
import cn.qihangerp.api.common.security.LoginUser;
import cn.qihangerp.api.common.security.SecurityUtils;
import cn.qihangerp.api.common.security.TokenService;
import cn.qihangerp.api.common.utils.IpUtils;
import cn.qihangerp.api.common.utils.NumberUtils;
import cn.qihangerp.api.domain.SysUser;
import cn.qihangerp.api.service.ISysUserService;
import cn.qihangerp.api.service.SysLoginService;
import com.alibaba.fastjson2.JSONObject;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.concurrent.TimeUnit;

/**
 * @author XuYifei
 * @date 2024-07-12
 */
@Slf4j
@Component
public class WxLoginHelper {
    @Autowired
    private SysLoginService loginService;
    @Autowired
    private ISysUserService userService;
    @Autowired
    private TokenService tokenService;

    /**
     * sse的超时时间，默认15min
     */
    private final static Long SSE_EXPIRE_TIME = 15 * 60 * 1000L;
//    private final LoginService sessionService;
    /**
     * key = 验证码, value = 长连接
     */
    private LoadingCache<String, SseEmitter> verifyCodeCache;
    /**
     * key = 设备 value = 验证码
     */
    private LoadingCache<String, String> deviceCodeCache;
    @Autowired
    private RedisCache redisCache;
    public WxLoginHelper() {
//        this.sessionService = loginService;
        verifyCodeCache = CacheBuilder.newBuilder().maximumSize(300).expireAfterWrite(5, TimeUnit.MINUTES).build(new CacheLoader<String, SseEmitter>() {
            @Override
            public SseEmitter load(String s) throws Exception {
                throw new NoVlaInGuavaException("no val: " + s);
            }
        });

        deviceCodeCache = CacheBuilder.newBuilder().maximumSize(300).expireAfterWrite(5, TimeUnit.MINUTES).build(new CacheLoader<String, String>() {
            @Override
            public String load(String s) {
                int cnt = 0;
                while (true) {
//                    String code = CodeGenerateUtil.genCode(cnt++);
                    String code = "DL"+NumberUtils.generateRandom6();
                    if (!verifyCodeCache.asMap().containsKey(code)) {
                        return code;
                    }
                }
            }
        });
    }

    /**
     * 保持与前端的长连接
     * <p>
     * 直接根据设备拿之前初始化的验证码，不直接使用传过来的code
     *
     * @return
     */
    public SseEmitter subscribe(String deviceId) throws IOException {
//        String deviceId = ReqInfoContext.getReqInfo().getDeviceId();
        String realCode = deviceCodeCache.getUnchecked(deviceId) ;
        redisCache.setCacheObject("MP_LOGIN_CODE:"+realCode,deviceId,5,TimeUnit.MINUTES);
        // fixme 设置15min的超时时间, 超时时间一旦设置不能修改；因此导致刷新验证码并不会增加连接的有效期
        SseEmitter sseEmitter = new SseEmitter(SSE_EXPIRE_TIME);
        SseEmitter oldSse = verifyCodeCache.getIfPresent(realCode);
        if (oldSse != null) {
            oldSse.complete();
        }
        verifyCodeCache.put(realCode, sseEmitter);
        sseEmitter.onTimeout(() -> {
            log.info("sse 超时中断 --> {}", realCode);
            verifyCodeCache.invalidate(realCode);
            sseEmitter.complete();
        });
        sseEmitter.onError((e) -> {
            log.warn("sse error! --> {}", realCode, e);
            verifyCodeCache.invalidate(realCode);
            sseEmitter.complete();
        });
        // 若实际的验证码与前端显示的不同，则通知前端更新
        sseEmitter.send("initCode!");
        sseEmitter.send("init#" + realCode);
        return sseEmitter;
    }

    public String resend(String deviceId) throws IOException {
        // 获取旧的验证码，注意不使用 getUnchecked, 避免重新生成一个验证码
//        String deviceId = ReqInfoContext.getReqInfo().getDeviceId();
        String oldCode = deviceCodeCache.getIfPresent(deviceId);
        SseEmitter lastSse = oldCode == null ? null : verifyCodeCache.getIfPresent(oldCode);
        if (lastSse != null) {
            lastSse.send("resend!");
            lastSse.send("init#" + oldCode);
            return oldCode;
        }
        return "fail";
    }

    /**
     * 刷新验证码
     *
     * @return
     * @throws IOException
     */
    public String refreshCode(String deviceId) throws IOException {
//        String deviceId = ReqInfoContext.getReqInfo().getDeviceId();
        // 获取旧的验证码，注意不使用 getUnchecked, 避免重新生成一个验证码
        String oldCode = deviceCodeCache.getIfPresent(deviceId);
        SseEmitter lastSse = oldCode == null ? null : verifyCodeCache.getIfPresent(oldCode);
        if (lastSse == null) {
            log.info("last deviceId:{}, code:{}, sse closed!", deviceId, oldCode);
            deviceCodeCache.invalidate(deviceId);
            return null;
        }

        // 重新生成一个验证码
        deviceCodeCache.invalidate(deviceId);
        String newCode = deviceCodeCache.getUnchecked(deviceId);
        log.info("generate new loginCode! deviceId:{}, oldCode:{}, code:{}", deviceId, oldCode, newCode);

        lastSse.send("updateCode!");
        lastSse.send("refresh#" + newCode);
        verifyCodeCache.invalidate(oldCode);
        verifyCodeCache.put(newCode, lastSse);
        return newCode;
    }

    /**
     * 微信公众号登录
     *
     * @param verifyCode 用户输入的登录验证码
     * @return
     */
    public boolean login(String verifyCode) {
        // 通过验证码找到对应的长连接
        SseEmitter sseEmitter = verifyCodeCache.getIfPresent(verifyCode);
        if (sseEmitter == null) {
            return false;
        }

//        String session = sessionService.loginByWx(ReqInfoContext.getReqInfo().getUserId());
        String token = loginService.login("qihang", "admin123", "",null);
        try {
            // 登录成功，写入session
            sseEmitter.send(token);
            // 设置cookie的路径
            sseEmitter.send("login#Token=" + token + ";path=/;");
            return true;
        } catch (Exception e) {
            log.error("登录异常: {}", verifyCode, e);
        } finally {
            sseEmitter.complete();
            verifyCodeCache.invalidate(verifyCode);
        }
        return false;
    }
    public boolean login(String verifyCode,String fromUserName) {
        // 通过验证码找到对应的长连接
        SseEmitter sseEmitter = verifyCodeCache.getIfPresent(verifyCode);
        if (sseEmitter == null) {
            return false;
        }
//        Object cacheObject = redisCache.getCacheObject("MP_LOGIN_CODE:" + verifyCode);
        String token = "";
        SysUser sysUser = userService.selectUserByWxOpenId(fromUserName);
        if(sysUser == null) {
            //新增用户
            String userName ="user"+NumberUtils.generateOrderNumber();
            log.info("=============新增用户====={}", userName);
            SysUser newUser = new SysUser();
            newUser.setUserName(userName);
            newUser.setNickName("微信公众号扫码登录用户");
            newUser.setPassword(SecurityUtils.encryptPassword("123456"));
            //试用期一个月
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            String expirationDate = LocalDate.now().plusMonths(1L).format(formatter);
            newUser.setExpirationDate(expirationDate);
            newUser.setLoginDate(new Date());
            newUser.setCreateBy("微信公众号扫码登录");
            newUser.setCreateTime(new Date());
            newUser.setWxOpenId(fromUserName);

            userService.insertUser(newUser);
            token = loginService.login(userName, "123456", "",null);
        }else{
            log.info("=============老用户登录====={}", JSONObject.toJSONString(sysUser));
            LoginUser loginUser = new LoginUser();
            loginUser.setUser(sysUser);
            loginUser.setUserId(sysUser.getUserId());
            loginUser.setLoginLocation("");
            loginUser.setLoginTime(System.currentTimeMillis()/1000);
            loginUser.setDeptId(sysUser.getDeptId());
            token = tokenService.createToken(loginUser);
        }
//        String session = sessionService.loginByWx(ReqInfoContext.getReqInfo().getUserId());

//        tokenService.createToken(sysUser);
        try {
            // 登录成功，写入session
            sseEmitter.send(token);
            // 设置cookie的路径
            sseEmitter.send("login#Token=" + token + ";path=/;");
            return true;
        } catch (Exception e) {
            log.error("登录异常: {}", verifyCode, e);
        } finally {
            sseEmitter.complete();
            verifyCodeCache.invalidate(verifyCode);
        }
        return false;
    }
}
