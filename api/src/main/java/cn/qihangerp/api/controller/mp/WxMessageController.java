package cn.qihangerp.api.controller.mp;

import cn.qihangerp.api.common.ResultVo;
import cn.qihangerp.api.common.utils.AddressUtils;
import cn.qihangerp.api.common.utils.IpUtils;
import cn.qihangerp.api.domain.SysConfig;
import cn.qihangerp.api.service.SysConfigService;
import com.hankcs.hanlp.HanLP;
import com.hankcs.hanlp.seg.common.Term;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.w3c.dom.Document;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.*;
import java.util.List;
import java.util.Map;

/**
 * 微信消息
 */
@Slf4j

@AllArgsConstructor
@RequestMapping("/wxmp")
@RestController
public class WxMessageController {
    private final WxLoginHelper qrLoginHelper;
    private final SysConfigService sysConfigService;

    @RequestMapping("/message")
    public String message(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String method = request.getMethod();
        log.info("=====收到微信消息===="+method);
        String echostr = request.getParameter("echostr");
        // 获取所有请求参数
        Map<String, String[]> parameterMap = request.getParameterMap();

        for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
            String paramName = entry.getKey();
            String[] paramValues = entry.getValue();
            // 打印参数名和参数值
            log.info("=====收到微信消息====Parameter Name: " + paramName);
            for (String value : paramValues) {
                log.info("=====收到微信消息====Value: " + value);
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
            }
            String requestBody = stringBuilder.toString();
            /**
             * <xml><ToUserName><![CDATA[gh_2c3122466618]]></ToUserName><FromUserName><![CDATA[oej2Jjl6DV9Y3w5zdeeGrjwlAN3M]]></FromUserName><CreateTime>1744532905</CreateTime><MsgType><![CDATA[text]]></MsgType><Content><![CDATA[6935]]></Content><MsgId>24975703988722696</MsgId></xml>
             *
             */
            log.info("=====收到微信消息====Body: " + requestBody);
            try {
                // 创建DocumentBuilderFactory对象并解析xml字符串
                DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                DocumentBuilder builder = factory.newDocumentBuilder();
                InputStream is = new ByteArrayInputStream(requestBody.getBytes("UTF-8"));
                Document document = builder.parse(is);

                // 获取xml中的数据
                String toUserName = document.getElementsByTagName("ToUserName").item(0).getTextContent();
                String fromUserName = document.getElementsByTagName("FromUserName").item(0).getTextContent();
                String createTime = document.getElementsByTagName("CreateTime").item(0).getTextContent();
                String msgType = document.getElementsByTagName("MsgType").item(0).getTextContent();
                if(msgType.equals("text")) {

                    String msg = "启航电商ERP系统有开源版本和商业版本之分，如果您有需求可以直接说说您的需求，并留下您的联系方式！";
                    String content = document.getElementsByTagName("Content").item(0).getTextContent();
                    String msgId = document.getElementsByTagName("MsgId").item(0).getTextContent();
                    log.info("=========接受到用户发消息========{}===={}", content,content.substring(0,2));

                    // 先判断是否登陆
                    if(content.length()==8&&content.substring(0,2).equals("DL")){
                        log.info("======用户登陆============");
                        qrLoginHelper.login(content,fromUserName);
                        log.info("===========登陆成功==========");
                        return "";
                    }
                    ResultVo<SysConfig> resultVo = sysConfigService.getSysConfigValue("mp.msg", content);

                    if (resultVo.getCode() == 0) {
                        msg = resultVo.getData().getConfigValue();
                    }else{
                        log.info("========没有找到，分词再招一遍=====");
                        List<Term> terms = HanLP.segment(content);
                        log.info("=========分词结果========");
                        for (Term term : terms) {
                            //ns地名nr人名n名词v动词
                            log.info("========={}========",term);
                            if (term.nature.toString().startsWith("v")) {
                                ResultVo<SysConfig> resultVo1 = sysConfigService.getSysConfigValue("mp.msg", term.word);
                                if (resultVo1.getCode() == 0) {
                                    msg = resultVo1.getData().getConfigValue();
                                    break;
                                }
                            }
                        }
                    }
                    String responseMessage = createTextMessage(fromUserName, toUserName, msg);
                    // 3. 回复消息
                    response.setContentType("text/xml;charset=UTF-8");
                    OutputStream out = response.getOutputStream();
                    out.write(responseMessage.getBytes("UTF-8"));
                    out.close();

                }else if(msgType.equals("event")) {

                    String event = document.getElementsByTagName("Event").item(0).getTextContent();
                    log.info("=========接受到用户事件========{}",event);
                    if(event.equals("subscribe")){
                        String msg="感谢关注启航电商ERP公众号，希望在这里能给您的业务带来帮助！有任何疑问可以联系作者！";
                        ResultVo<SysConfig> resultVo = sysConfigService.getSysConfigValue("mp.subscribe.msg");
                        if(resultVo.getCode()==0){
                            msg = resultVo.getData().getConfigValue();
                        }
                        String responseMessage = createTextMessage(fromUserName,toUserName,msg);
                        // 3. 回复消息
                        response.setContentType("text/xml;charset=UTF-8");
                        OutputStream out = response.getOutputStream();
                        out.write(responseMessage.getBytes("UTF-8"));
                        out.close();
                        log.info("==========感谢关注=========");
                    }
                }


                // 输出解析结果
                log.info("ToUserName: " + toUserName);
                log.info("FromUserName: " + fromUserName);
                log.info("CreateTime: " + createTime);
                log.info("MsgType: " + msgType);


            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        log.info("=========真正处理微信消息业务========={}");


        return echostr;
    }

    // 创建文本消息
    private String createTextMessage(String fromUserName, String toUserName, String content) {
        long createTime = System.currentTimeMillis() / 1000;
        return "<xml>" +
                "<ToUserName><![CDATA[" + fromUserName + "]]></ToUserName>" +
                "<FromUserName><![CDATA[" + toUserName + "]]></FromUserName>" +
                "<CreateTime>" + createTime + "</CreateTime>" +
                "<MsgType><![CDATA[text]]></MsgType>" +
                "<Content><![CDATA[" + content + "]]></Content>" +
                "</xml>";
    }
}
