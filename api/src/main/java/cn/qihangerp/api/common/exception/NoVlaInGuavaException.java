package cn.qihangerp.api.common.exception;

/**
 * 未命中异常
 *
 * @author XuYifei
 * @date 2024-07-12
 */
public class NoVlaInGuavaException extends RuntimeException {
    public NoVlaInGuavaException(String msg) {
        super(msg);
    }

    @Override
    public synchronized Throwable fillInStackTrace() {
        return this;
    }
}