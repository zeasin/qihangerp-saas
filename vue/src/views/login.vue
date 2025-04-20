<template>
  <div class="login">
    <div class="layout">
      <div class="bgLeft"></div>
      <div class="bgRight"></div>
      <h3 class="title">启航电商ERP系统-微信小店版</h3>
      <div class="login-form">
        <div class="zhuce"  v-if="n !==3"></div>
        <div class="tabs" v-if="n !==3">
          <div class="item" :class="n==1?'on':''" @click="n=1">密码登录</div>
          <div class="item" :class="n==2?'on':''" @click="n=2">扫码关注</div>
        </div>
        <div class="zhuce" v-else>注册</div>
        <!--star 密码登录-->
        <el-form ref="loginForm" :model="loginForm" :rules="loginRules" v-if="n==1">
          <el-form-item prop="username">
            <el-input
              v-model="loginForm.username"
              type="text"
              auto-complete="off"
              placeholder="账号/手机号"
            >
              <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon" />
            </el-input>
          </el-form-item>
          <el-form-item prop="password">
            <el-input
              v-model="loginForm.password"
              type="password"
              auto-complete="off"
              placeholder="密码"
              @keyup.enter.native="handleLogin"
            >
              <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
            </el-input>
          </el-form-item>
          <el-form-item prop="code" v-if="captchaEnabled">
            <el-input
              v-model="loginForm.code"
              auto-complete="off"
              placeholder="验证码"
              style="width: 63%"
              @keyup.enter.native="handleLogin"
            >
              <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon" />
            </el-input>
            <div class="login-code">
              <img :src="codeUrl" @click="getCode" class="login-code-img"/>
            </div>
          </el-form-item>
          <el-checkbox v-model="loginForm.rememberMe" style="margin:0px 0px 25px 0px;">记住密码</el-checkbox>
          <el-form-item style="width:100%;">
            <el-button class="btns"
              :loading="loading"
              size="medium"
              type="primary"
              style="width:100%;"
              @click.native.prevent="handleLogin"
            >
              <span v-if="!loading">登 录</span>
              <span v-else>登 录 中...</span>
            </el-button>
          </el-form-item>
        </el-form>
        <!--end 密码登录-->
        <!--star 验证码登录-->
        <el-form :model="form" ref="form" :rules="codeRules" v-if="n==2">
          <el-image  width="50px" height="10rem" src="http://img.qihangerp.cn/qihangerpcn_wxmp.jpg"></el-image>
          <el-cell>
            <div class="explain center-content">
              <span >扫码关注微信公众号。</span><br/>
              <span ><bold>输入验证码</bold> <span class="link-color">{{code}}</span></span>
              <div><span id="state">有效期五分钟 👉</span>
<!--                <a class="bold-span underline cursor-pointer link-color" @click="refreshCode">手动刷新</a>-->
              </div>
            </div>
          </el-cell>
<!--          <el-form-item prop="phone">-->
<!--            <el-input type="tel" :maxlength="11" v-model.trim="form.phone" placeholder="请输入手机号">-->
<!--              <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon" />-->
<!--            </el-input>-->
<!--          </el-form-item>-->
<!--          <el-form-item prop="checkMove">-->
<!--            <div class="movebox">-->
<!--              <div class="movego"></div>-->
<!--              <div class="txt" id="txt">按住滑块,拖动到最右边</div>-->
<!--              <div class="move moveBefore" v-move="pull"></div> &lt;!&ndash; v-move 为自定义指令 &ndash;&gt;-->
<!--            </div>-->
<!--          </el-form-item>-->
<!--          <el-form-item prop="smsCode" v-show="isCode">-->
<!--            <el-input placeholder="请输入验证码" style="width: 63%" v-model.trim="form.smsCode" autocomplete="off">-->
<!--              <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon" />-->
<!--            </el-input>-->
<!--            <div class="login-code">-->
<!--              <el-button @click="sendCode('form')" :disabled="!show">-->
<!--              <span v-show="show">获取验证码</span>-->
<!--              <span v-show="!show">已发送 {{count}}s</span>-->
<!--            </el-button>-->
<!--            </div>-->
<!--          </el-form-item>-->
<!--          <el-form-item style="width:100%;">-->
<!--            <el-button class="btns"-->
<!--              :loading="loading"-->
<!--              size="medium"-->
<!--              type="primary"-->
<!--              style="width:100%;"-->
<!--              @click="codeLogin('form')"-->
<!--            >-->
<!--              <span v-if="!loading">登 录</span>-->
<!--              <span v-else>登 录 中...</span>-->
<!--            </el-button>-->
<!--          </el-form-item>-->
        </el-form>
        <!--end 验证码登录-->
        <!--star 注册-->
        <el-form ref="registerForm" :model="registerForm" :rules="registerRules" v-if="n==3">
          <el-form-item prop="phone">
            <el-input
              v-model="registerForm.phone"
              type="text"
              auto-complete="off"
              placeholder="请输入您的手机号"
            >
              <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon" />
            </el-input>
          </el-form-item>
          <el-form-item prop="passwords">
            <el-input
              v-model="registerForm.passwords"
              type="password"
              auto-complete="off"
              placeholder="请输入您的密码"
            >
              <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
            </el-input>
          </el-form-item>
          <el-form-item prop="passwordok">
            <el-input
              v-model="registerForm.passwordok"
              type="password"
              auto-complete="off"
              placeholder="请再次确认您的密码"
            >
              <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
            </el-input>
          </el-form-item>
          <el-form-item style="width:100%;">
            <el-button class="btns"
              :loading="loading"
              size="medium"
              type="primary"
                       @click="signOn"
              style="width:100%;"
            >
              <span v-if="!loading">注 册</span>
              <span v-else>注 册 中...</span>
            </el-button>
          </el-form-item>
        </el-form>
        <!--end 注册-->
        <p class="register" v-if="n !== 3">没有账号？<span @click="n=3">立即注册</span></p>
        <p class="register" v-else>我已有账号<span @click="n=1">立即登录</span></p>
      </div>
    </div>
    <!--  底部  -->
    <div class="el-login-footer">
      <span>Copyright © 2023-2024 qihangerp.cn All Rights Reserved.</span>
    </div>
  </div>
</template>

<script>
import Cookies from "js-cookie";
import { encrypt, decrypt } from '@/utils/jsencrypt'
import { getCodeImg,signOn } from "@/api/login";
export default {
  name: "Login",
  data() {
    return {
      n:1,
      codeUrl: "",
      code: "",
      loginForm: {
        username: "",
        password: "",
        rememberMe: false,
        code: "",
        uuid: ""
      },
      loginRules: {
        username: [
          { required: true, trigger: "blur", message: "请输入您的账号" }
        ],
        password: [
          { required: true, trigger: "blur", message: "请输入您的密码" }
        ],
        code: [{ required: true, trigger: "change", message: "请输入验证码" }]
      },
      loading: false,
      // 验证码开关
      captchaEnabled: false,
      // 注册开关
      register: false,
      redirect: undefined,

      show: true,
      isCode: false,
      count: 60,
      form: {
        phone: "",
        smsCode: "",
        checkMove: "",
      },
      codeRules: {
        phone: [
          { required: true, message: '请输入手机号', trigger: 'blur' },
        ],
        smsCode: [{ required: true, message: '请输入手机验证码', trigger: 'blur' }],
        checkMove: [{ required: true, message: '滑动完成验证', trigger: 'blur' }],
      },

      registerForm:{
        phone: "",
        passwords: "",
        passwordok: "",
      },
      registerRules: {
        phone: [
          { required: true, message: '请输入您的账号', trigger: 'blur' },
          { pattern: /^1[3-9]\d{9}$/, message: '请输入有效的手机号', trigger: 'blur' }
        ],
        passwords: [
          { required: true, message: '请输入您的密码', trigger: 'blur' },
          { min: 6, trigger: 'blur', message: '密码长度不能小于 6 位' }
        ],
        passwordok: [
          { required: true, message: '请再此确认您的密码', trigger: 'blur' },
          { min: 6, trigger: 'blur', message: '密码长度不能小于 6 位' }
        ],
      },
    };
  },
  watch: {
    $route: {
      handler: function(route) {
        this.redirect = route.query && route.query.redirect;
      },
      immediate: true
    }
  },
  created() {
    this.getCode();
    this.getCookie();
  },
  directives: {
    move(el, binding, vnode) {
      let vm = this;
      el.onmousedown = function (e) {
        var X = e.clientX - el.offsetLeft;
        document.onmousemove = function (e) {
          var endx = e.clientX - X;
          el.className = "move moveBefore";
          el.style.left = endx + "px";
          var width = document.querySelector(".movebox").offsetWidth - document.querySelector(".move").offsetWidth;
          el.parentNode.children[0].style.width = endx + 20 + "px";
          el.parentNode.children[1].innerHTML = "按住滑块,拖动到最右边";
          //临界值小于
          if (endx <= 0) {
            el.style.left = 0 + "px";
            el.parentNode.children[0].style.width = 0 + "px";
          }

          //临界值大于
          if (parseInt(el.style.left) >= width) {
            if(vnode.context.form.phone == ''){
              el.style.left = 0 + "px";
              el.parentNode.children[0].style.width = 0 + "px";
              el.className = "move moveBefore";
              document.onmousemove = null;
              vnode.context.$message({
                message: '请输入手机号',
                type: 'warning'
              });
            }else{
              el.style.left = width + "px";
              el.parentNode.children[0].style.width = width + 20 + "px";
              el.parentNode.children[1].innerHTML = "<span style='-webkit-text-fill-color: #fff;'>验证通过</span>";
              el.className = "move moveSuccess";
              document.onmousemove = null;
              el.onmousedown = null;
              binding.value()
            }
          }
        };
      };
      document.onmouseup = function () {
        document.onmousemove = null;
      };
    }
  },
  methods: {
    validatePhone() {
      // 中国大陆手机号码的正则表达式（11位数字，以1开头，第二位数字不固定）
      const phonePattern = /^1\d{10}$/;
      if (!phonePattern.test(this.phone)) {
        this.phoneError = true;
        this.phoneErrorMessage = '手机号码格式不正确';
      } else {
        this.phoneError = false;
        this.phoneErrorMessage = '';
      }
    },
    getCookie() {
      const username = Cookies.get("username");
      const password = Cookies.get("password");
      const rememberMe = Cookies.get('rememberMe')
      this.loginForm = {
        username: username === undefined ? this.loginForm.username : username,
        password: password === undefined ? this.loginForm.password : decrypt(password),
        rememberMe: rememberMe === undefined ? false : Boolean(rememberMe)
      };
    },
    handleLogin() {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          this.loading = true;
          if (this.loginForm.rememberMe) {
            Cookies.set("username", this.loginForm.username, { expires: 30 });
            Cookies.set("password", encrypt(this.loginForm.password), { expires: 30 });
            Cookies.set('rememberMe', this.loginForm.rememberMe, { expires: 30 });
          } else {
            Cookies.remove("username");
            Cookies.remove("password");
            Cookies.remove('rememberMe');
          }
          this.$store.dispatch("Login", this.loginForm).then(() => {
            this.$router.push({ path: this.redirect || "/" }).catch(()=>{});
          }).catch(() => {
            this.loading = false;
            if (this.captchaEnabled) {
              this.getCode();
            }
          });
        }
      });
    },
    getCode() {
      // getCodeImg().then(res => {
      //   this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled;
      //   if (this.captchaEnabled) {
      //     this.codeUrl = "data:image/gif;base64," + res.img;
      //     this.loginForm.uuid = res.uuid;
      //   }
      // });
    },
    //注册
    signOn(){
      this.$refs.registerForm.validate(valid => {
        if (valid) {
          if(this.registerForm.passwordok!=this.registerForm.passwords){
            this.$modal.msgError("两次密码不一致")
            return;
          }
          this.loading = true;
          signOn(this.registerForm).then(resp=>{
            this.loading = false
            this.$modal.msgSuccess("注册成功！正在登录！")
           this.loginForm={
              username: this.registerForm.phone,
                password: this.registerForm.passwords,
                rememberMe: false,
                code: "",
                uuid: ""
            },
            this.$store.dispatch("Login", this.loginForm).then(() => {
              this.$router.push({ path: this.redirect || "/" }).catch(()=>{});
            }).catch(() => {
              this.loading = false;
              if (this.captchaEnabled) {
                this.getCode();
              }
            });
          })
        }
      })
    },
    pull() {
      if(this.form.phone){
        this.form.checkMove = true;
      }
      if(this.form.checkMove){
        this.isCode = true
      }
    },
    //发送短信验证码
    sendCode(formName) {
      console.log(this.form.checkMove, 11)
      if (!this.form.phone) {
        this.$message({
          message: '请输入手机号',
          type: 'warning'
        });
        return;
      }
      if (!this.form.checkMove) {
        this.$message({
          message: '滑块验证有误，请重新验证',
          type: 'warning'
        });
        return;
      }

      let params = {
        // ...
      }
      //发送短信验证码接口
      sendVerificationCode(params).then(res => {
        if (res.code === 0) {
          this.show = false;
          let timeId = setInterval(() => {
            if (this.count <= 0) {
              this.show = true;
              clearInterval(timeId);
              this.count = 60;
            } else {
              this.count--;
            }
          }, 1000)
        } else {
          this.$message.error(res.message);
        }
      })

    },
    codeLogin() { }

  }
};
</script>

<style rel="stylesheet/scss" lang="scss">
.login {
  font-family: Barlow;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 800px;
  height: 100%;
  width: 100%;
  // background-size: cover;
  background-image: url("../assets/images/login-background.png");
  background-attachment: fixed;
  overflow: hidden;
  .layout{
    position: relative;
    z-index: 3;
    height: 100%;
  }
  .bgLeft{
    position: absolute;
    width: 590px;
    height: 590px;
    bottom: 0;
    left: -359px;
    background-image: url("../assets/images/backgroundLeft.png");
    background-size: cover;
  }
  .bgRight{
    position: absolute;
    width: 414px;
    height: 414px;
    top: 0;
    right: -211px;
    background-image: url("../assets/images/backgroundRight.png");
    background-size: cover;
  }
  .title {
    margin: 79px auto 40px;
    text-align: center;
    color: #000000;
    font-size: 24px;
    font-weight: bold;
  }

}
.login-form {
  border-radius: 16px;
  width: 428px;
  min-height: 500px;
  padding-top: 68px;
  position: relative;
  z-index: 9999;
  box-shadow: 0 20px 80px 0 rgba(45,66,119,.10196);
  background: hsla(0, 0%, 100%, .65);
  border: 1px solid #fff;
  .zhuce{
    font-weight: 600;
    height: 20px;
    font-size: 20px;
    line-height: 20px;
    color: #333;
    text-align: center;
  }
  .tabs{
    display: flex;
    padding: 0 54px;
    text-align: center;
    .item{
      width: 50%;
      height: 20px + 12px;
      font-size: 20px;
      line-height: 20px;
      color: #333;
      font-weight: 600;
      position: relative;
      cursor: pointer;
      &.on{
        color: #307dff;
        &::after{
          content: '';
          position: absolute;
          bottom: 0;
          left: 0;
          right: 0;
          height: 3px;
          width: 28px;
          margin: 12px auto 0;
          background-color: #307dff;
        }
      }
    }
  }
  .el-form{
    padding: 0px 48px 99px;
    margin-top: 32px;
    .btns{
      color: #fff;
      background-color: #307dff;
      border-color: #307dff;
      width: 100%;
      border-radius: 8px;
      padding: 15px 0;
      font-weight: 500;
    }
  }
  .el-input {
    height: 46px;
    input {
      height: 46px;
      line-height: 46px;
      border-color: #e4e4e4;
      border-radius: 8px;
      padding-left: 40px;
      color: #000000;
    }
  }
  .input-icon {
    height: 46px;
    width: 14px;
    margin-left: 10px;
  }
  .register{
    width: 100%;
    height: 14px;
    line-height: 14px;
    color: #666;
    text-align: center;
    font-size: 14px;
    position: absolute;
    bottom: 48px;
    span{
      font-size: 14px;
      margin-left: 8px;
      color: #3179f8!important;
      cursor: pointer;
    }
  }
}
.login-tip {
  font-size: 13px;
  text-align: center;
  color: #bfbfbf;
}
.login-code {
  width: 33%;
  height: 46px;
  float: right;
  .el-button{
    height: 46px;
    padding: 0;
    width: 100%;
    border-radius: 8px;
    font-weight: bold;
    color: #000000;
  }
  img {
    cursor: pointer;
    vertical-align: middle;
  }
}
.el-login-footer {
  height: 40px;
  line-height: 40px;
  position: fixed;
  z-index: 2;
  bottom: 0;
  width: 100%;
  text-align: center;
  color: #000000;
  font-family: Arial;
  font-size: 12px;
  letter-spacing: 1px;
}
.login-code-img {
  height: 38px;
}

.movebox {
  position: relative;
  background-color: #e8e8e8;
  width: 100%;
  height: 46px;
  line-height: 46px;
  text-align: center;
  border-radius: 8px;
  overflow: hidden;
  .txt {
    position: absolute;
    top: 0px;
    width: 100%;
    -moz-user-select: none;
    -webkit-user-select: none;
    user-select: none;
    -o-user-select: none;
    -ms-user-select: none;
    font-size: 12px;
    color: #FFFFFF;

    background: -webkit-gradient(linear, left top, right top, color-stop(0, #4d4d4d), color-stop(.4, #4d4d4d), color-stop(.5, #fff), color-stop(.6, #4d4d4d), color-stop(1, #4d4d4d));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    -webkit-animation: slidetounlock 3s infinite;
    -webkit-text-size-adjust: none;
  }
  .movego {
    background-color: #7ac23c;
    height: 46px;
    width: 0px;
  }
  .move {
    position: absolute;
    top: 0px;
    left: 0px;
    width: 46px;
    height: 46px;
    border: 1px solid #e4e4e4;
    cursor: move;
    border-radius: 8px;
    background: #fff;
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center center;
  }
  .moveBefore {
    background-image: url("../assets/icons/moveBefore.png");
    background-size: 18px 18px;
  }
  .moveSuccess {
    background-image: url("../assets/icons/moveSuccess.png");
    background-size: 18px 18px;
    -webkit-text-fill-color: #fff;
  }
}
@keyframes slidetounlock{
  0%{
    background-position: -200px 0;
  }
  100%{
    background-position: 200px 0;
  }
}
</style>
