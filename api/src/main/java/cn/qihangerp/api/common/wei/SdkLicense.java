package cn.qihangerp.api.common.wei;

import cn.qihangerp.api.common.utils.http.ExpressClient;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@Slf4j
@Component
public class SdkLicense {
    @Value("${spring.application.name}")
    private String appName;
    @Value(("${server.port}"))
    private String appVersion;
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

    @PostConstruct
    public void startAuthorizationCheck() {
        scheduler.scheduleAtFixedRate(this::checkServerAuthorization, 0, 1, TimeUnit.HOURS);
    }
    @PostConstruct
    public void init() throws IOException {
        String uniqueID = UniqueIDGenerator.generateUniqueID();
//        System.out.println("Generated Unique ID: " + uniqueID);
        ExpressClient.getLicenseSdk(uniqueID,appName,appVersion);
    }

    private void checkServerAuthorization() {
        try {
            String uniqueID = UniqueIDGenerator.generateUniqueID();
//            log.info("Get License Unique ID: " + uniqueID);
            ExpressClient.getLicenseSdk(uniqueID,appName,appVersion);
        } catch (Exception e) {
//            e.printStackTrace();
        }
    }

}
