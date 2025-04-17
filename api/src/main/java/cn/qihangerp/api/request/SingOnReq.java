package cn.qihangerp.api.request;

import lombok.Data;

@Data
public class SingOnReq {
    private String phone;
    private String passwords;
    private String passwordok;
}
