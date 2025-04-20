package cn.qihangerp.api.controller.mp;


import cn.qihangerp.api.common.AjaxResult;
import cn.qihangerp.api.common.cache.RedisCache;
import cn.qihangerp.api.common.utils.NumberUtils;
import cn.qihangerp.api.common.utils.StringUtils;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;

@AllArgsConstructor
@Controller
@Slf4j
public class WxLoginController {

    private final WxLoginHelper qrLoginHelper;
    private final RedisCache redisCache;
    private static LoadingCache<String, SseEmitter> verifyCodeCache = CacheBuilder.newBuilder().maximumSize(300).expireAfterWrite(5, TimeUnit.MINUTES)
            .build(new CacheLoader<String, SseEmitter>() {
                @Override
                public SseEmitter load(String s) throws Exception {
                    throw new Exception("no val: " + s);
                }
            });

    /**
     * 客户端与后端建立扫描二维码的长连接
     *
     * @return
     */
    @ResponseBody
    @GetMapping(path = "/api/subscribe", produces = {org.springframework.http.MediaType.TEXT_EVENT_STREAM_VALUE})
    public SseEmitter subscribe(String deviceId) throws IOException {
        log.info("=====subscribe==={}",deviceId);
////        Object cache = redisCache.getCacheObject(deviceId);
//        // 生成验证码
//        String realCode = "DL"+ NumberUtils.generateRandom6();
////        if(cache == null) {
//            redisCache.setCacheObject(deviceId, realCode);
////        }
////        String realCode = deviceCodeCache.getUnchecked(deviceId) ;


        return qrLoginHelper.subscribe(deviceId);
    }

    @GetMapping(path = "/api/subscribe/fetch")
    @ResponseBody
    public String resendCode(String deviceId) throws IOException {
        log.info("=====fetch login===");
        Object cache = redisCache.getCacheObject(deviceId);
        String oldCode = cache.toString();
        log.info("=====fetch login==={}",oldCode.toString());
        return qrLoginHelper.resend(deviceId);
    }

    /**
     * 刷新验证码
     *
     * @return
     * @throws IOException
     */
    @GetMapping(path = "/api/subscribe/refresh")
    @ResponseBody
    public AjaxResult refresh(String deviceId) throws IOException {
        WxLoginVo vo = new WxLoginVo();
        String code = qrLoginHelper.refreshCode(deviceId);
        if (StringUtils.isBlank(code)) {
            // 刷新失败，之前的连接已失效，重新建立连接
            vo.setCode(code);
            vo.setReconnect(true);
        } else {
            vo.setCode(code);
            vo.setReconnect(false);
        }
        return AjaxResult.success(vo);
    }
}
