package cn.qihangerp.api.common.wei;

import java.net.NetworkInterface;
import java.util.Scanner;
import java.util.UUID;

public class UniqueIDGenerator {

    // 获取 MAC 地址
    public static String getMacAddress() {
        try {
//            NetworkInterface networkInterface = NetworkInterface.getByInetAddress(InetAddress.getLocalHost());
            NetworkInterface networkInterface = NetworkInterface.getByName("eth0");
            byte[] mac = networkInterface.getHardwareAddress();
            if (mac != null) {
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < mac.length; i++) {
                    sb.append(String.format("%02X", mac[i]));
                    if (i < mac.length - 1) sb.append("-");
                }
                return sb.toString();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "00-00-00-00-00-00"; // 默认返回一个固定值
    }

    // 获取硬盘序列号（Windows 下可通过 cmd 查询，Linux 下可以通过系统命令获取）
    public static String getDiskSerialNumber() {
        try {
            // 在 Windows 上可以使用命令行查询硬盘序列号
            if (System.getProperty("os.name").startsWith("Windows")) {
                return executeCommand("wmic diskdrive get serialnumber");
            } else if (System.getProperty("os.name").contains("mac")|| System.getProperty("os.name").contains("darwin")) {
                //  macOS 系统
                return executeCommand("system_profiler SPSerialATADataType | grep 'Serial Number' | sed 's/.*Serial Number: //' | tr -d '[:space:]'");
            }
            else {
                // 在 Linux 上通过命令获取硬盘序列号
                return executeCommand("lsblk -o SERIAL -n | head -n 1");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "0000000000000000"; // 默认值
    }

    // 执行命令并返回结果
    private static String executeCommand(String command) {
        try {
            Process process = Runtime.getRuntime().exec(command);
            Scanner sc = new Scanner(process.getInputStream()).useDelimiter("\\A");
            return sc.hasNext() ? sc.next().trim() : "";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    // 生成唯一ID
    public static String generateUniqueID() {
        String macAddress = getMacAddress();
        String diskSerialNumber = getDiskSerialNumber();

        // 将硬件信息拼接，并使用 SHA-256 哈希算法生成唯一 ID
        String combinedInfo = macAddress + diskSerialNumber;
        return UUID.nameUUIDFromBytes(combinedInfo.getBytes()).toString();
    }


}

