package cn.qihangerp.api.common.utils;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class NumberUtils {
    public static String generateOrderNumber() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); // 年月日时分秒
        String datePart = sdf.format(new Date());
        int randomNum = new Random().nextInt(1000); // 生成 0 到 999 之间的随机数
        return datePart + String.format("%03d", randomNum); // 确保随机数为3位
    }

    public static String generateRandomNumber() {
        int randomNum = new Random().nextInt(10000); // 生成 0 到 9999 之间的随机数
        return String.format("%04d", randomNum); // 确保随机数为3位
    }

    public static String generateRandom6() {
        int randomNum = new Random().nextInt(900000) + 100000; // 生成 100000 到 999999 之间的随机数
        return String.format("%06d", randomNum); // 确保随机数为6位
    }

    // 生成一个随机盐值
    public static String generateSalt(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder salt = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(chars.length());
            salt.append(chars.charAt(index));
        }
        return salt.toString();
    }
    // MD5 哈希加盐
    public static String md5WithSalt(String password, String salt) {
        try {
            // 密码和盐值拼接
            String saltedPassword = password + salt;

            // 获取 MD5 实例
            MessageDigest md = MessageDigest.getInstance("MD5");

            // 更新 MD5 实例
            md.update(saltedPassword.getBytes());

            // 生成 MD5 哈希值
            byte[] hashedBytes = md.digest();

            // 将哈希值转换成十六进制字符串
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashedBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }

            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
}
