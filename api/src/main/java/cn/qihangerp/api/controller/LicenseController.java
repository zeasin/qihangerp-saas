package cn.qihangerp.api.controller;

import cn.qihangerp.api.common.AjaxResult;
import cn.qihangerp.api.domain.ErpGoods;
import cn.qihangerp.api.domain.SysLicense;
import cn.qihangerp.api.service.SysLicenseService;
import com.alibaba.fastjson2.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Date;
import java.util.Map;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/license")
public class LicenseController {
    private final SysLicenseService sysLicenseService;

    @RequestMapping("/getLicense")
    public AjaxResult getLicense(HttpServletRequest request)
    {
        String method = request.getMethod();
        log.info("=====收到License请求===="+method);

        // 获取所有请求参数
        Map<String, String[]> parameterMap = request.getParameterMap();

        for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
            String paramName = entry.getKey();
            String[] paramValues = entry.getValue();
            // 打印参数名和参数值
            log.info("=====收到License请求====Parameter Name: " + paramName);
            for (String value : paramValues) {
                log.info("=====收到License请求====Value: " + value);
            }
        }
        if(method.equals("POST")){
            // 获取 POST 请求的 body 内容
            StringBuilder stringBuilder = new StringBuilder();
            String line;

            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    stringBuilder.append(line);
                }
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            String requestBody = stringBuilder.toString();
            log.info("=====收到License请求====Body: " + requestBody);
            try {
                JSONObject jsonObject = JSONObject.parseObject(requestBody);
                String uuid = jsonObject.getString("uuid");
                sysLicenseService.save(uuid, jsonObject.getLong("time"));

            } catch (Exception e) {
                log.info("====解析请求数据出错====={}",e.getMessage());
            }

        }
        return AjaxResult.success(1);
    }
}
