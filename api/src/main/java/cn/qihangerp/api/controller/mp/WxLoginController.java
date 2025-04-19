package cn.qihangerp.api.controller.mp;


import cn.qihangerp.api.common.cache.RedisCache;
import cn.qihangerp.api.common.utils.NumberUtils;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.core.internal.LoadingCache;
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

//    @GetMapping(path = "/api/login/fetch")
//    @ResponseBody
//    public String resendCode(String deviceId) throws IOException {
//        log.info("=====fetch login===");
//        Object cache = redisCache.getCacheObject(deviceId);
//        String oldCode = cache.toString();
////        LoadingCache<String, SseEmitter> verifyCodeCache = CacheBuilder.newBuilder().maximumSize(300).expireAfterWrite(5, TimeUnit.MINUTES)
////                .build(new CacheLoader<String, SseEmitter>() {
////                    @Override
////                    public SseEmitter load(String s) throws Exception {
////                        throw new Exception("no val: " + s);
////                    }
////                });
//        SseEmitter lastSse = verifyCodeCache.getIfPresent(oldCode);
//        if (lastSse != null) {
//            lastSse.send("resend!");
//            lastSse.send("init#" + oldCode);
//            log.info("fetch code");
//            return oldCode;
//        }
//        log.info("fetch fail");
//        return "fail";
//    }
}
