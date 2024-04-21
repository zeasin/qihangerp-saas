package cn.qihangerp.api.common.security;

import cn.qihangerp.api.common.exception.UserException;

/**
 * 用户错误最大次数异常类
 * 
 * @author qihang
 */
public class UserPasswordRetryLimitExceedException extends UserException
{
    private static final long serialVersionUID = 1L;

    public UserPasswordRetryLimitExceedException(int retryLimitCount, int lockTime)
    {
        super("user.password.retry.limit.exceed", new Object[] { retryLimitCount, lockTime });
    }
}
