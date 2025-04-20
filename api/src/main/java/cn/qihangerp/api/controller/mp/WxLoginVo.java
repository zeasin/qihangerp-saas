package cn.qihangerp.api.controller.mp;

import lombok.Data;

@Data
public class WxLoginVo {
    private String code;
    private Boolean reconnect;
}
