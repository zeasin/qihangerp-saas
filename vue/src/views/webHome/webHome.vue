<template>
    <!-- star容器 -->
    <div id="page-container" class="page-container" ref="scrollcontainer">
      <!--star header-->
      <div id="header" class="header" :class="isTop?'theme':''">
        <div class="header-box">
          <!-- logo -->
          <img class="header-logo" referrerpolicy="no-referrer" src="https://www.yiguaerp.com/Assets/img/logo.png" />
          <!-- 导航栏 -->
          <nav class="navbar">
            <ul class="nav navbar-nav">
              <li v-for="(item,index) in navList" :key="index"><a>{{ item.title }}</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
              <li><a class="to-website">登录</a></li>
              <li><a class="to-website concat-btn concat-login-click"><span>注册</span></a></li>
            </ul>
          </nav>
        </div>
      </div>
      <!--end header-->
      <!--star 右下脚-企业微信客服-->
      <div class="scroll-service-button">
        <img src="https://www.yiguaerp.com/Assets/img/service.png">
        <div class="p-r">
          <div class="service p-a">
            <p class="service-title">企业微信客服</p>
            <p class="service-time">每日在线 08:00-24:00</p>
            <img class="service-qrcode" src="https://www.yiguaerp.com/Assets/img/service-qrcode.png">
            <p class="service-label">
              <i class="el-icon-full-screen" style="margin-right: 6px;"></i>
              扫码咨询客服
            </p>
          </div>
        </div>
      </div>
      <div class="scroll-top-button" v-if="isTop" @click="onBackTop()"><p></p></div>
      <!--end 右下脚-企业微信客服-->
      <!-- main -->
      <div id="main" class="main">
        <section class="section1">
          <div class="section1-content">
            <div class="section1-content-box">
              <h1>提升直播经营利润</h1>
              <h1>就用易瓜ERP</h1>
              <div class="flex-item-center" style="margin-top: 24px;">
                <div class="flex-item-center" :class="index !== 0?'ml20':''" v-for="(item,index) in oneList">
                  <img class="section1-icon" :src="item.icon">
                  <p class="section1-label">{{item.title}}</p>
                </div>
              </div>
              <p class="section1-desc">多店订单统一管理，商品库存成本精准统计，智能生成直播利润报表，助力商家经营决策。</p>
              <div class="p-r" style="display: inline-block;">
                <a href="javascript:void(0)"
                  class="to-website section1-concat-btn concat-btn-click">
                  <span class="flex-item-center">
                    免费试用
                    <div class="concat-arrow-right">
                      <i class="el-icon-right"></i>
                    </div>
                  </span>
                </a>
                <img class="free-img" src="https://www.yiguaerp.com/Assets/img/home/free.png">
              </div>
            </div>
          </div>
        </section>

        <div class="tabs">
          <div class="tab" :class="index !== 1?'p-r':''" v-for="(item,index) in twoList" :key="index">
            <img :src="item.samllIcon" class="tab-img">
            <div class="p-a" style="bottom: 24px;">
              <div class="flex-item-center tab-title">
                <img :src="item.bigIcon" class="tab-img-1">
                <span style="position: relative;">
                  {{item.title}}
                  <img v-if="item.isHot" src="https://www.yiguaerp.com/Assets/img/home/new.png?v=202311171611" class="hot-img">
                </span>
              </div>
              <p class="tab-label">{{item.desc}}</p>
            </div>
          </div>
        </div>

        <!--star 解决方案-->
        <p class="headline">{{ solutionList.title }}</p>
        <section class="section2 section" ref="boxSection2">
          <div :class="index==0?'anim-section2-show':''" v-for="(item,index) in solutionList.contentList" :key="index">
            <div class="section2-content" v-if="item.layout=='left'">
              <div class="left-box anim-left-to-right" :class="item.leftClass">
                <p class="left-box-title" :style="'color:'+item.color">{{ item.title }}</p>
                <p class="left-box-label" v-for="(items,indexs) in item.list" :key="indexs"><img :src="section1check"
                    class="icon-check" />{{ items }}</p>
                <a :style="'color:'+item.btnColor" class="to-website sample-btn">免费试用<i :style="'color:'+item.btnColor" class="el-icon-right"></i></a>
                <div class="left-box-icon"><img :class="item.isImageStyle" v-if="item.isImageUrl" :src="item.isImageUrl" /></div>
              </div>
              <div class="right-box p-r anim-right-to-left" :class="item.rightClass" v-html="item.imageHtml"></div>
            </div>
            <div class="section2-content" v-if="item.layout=='right'">
              <div class="right-box anim-left-to-right p-r" :class="item.rightClass" v-html="item.imageHtml"></div>
              <div class="left-box anim-right-to-left" :class="item.leftClass" style="border-radius: 0 16px 16px 0;">
                <p class="left-box-title" :style="'color:'+item.color">{{ item.title }}</p>
                <p class="left-box-label" :style="'color:'+items.color" v-for="(items,indexs) in item.list" :key="indexs"><img :src="section1check"
                    class="icon-check" />{{ items }}</p>
                <a class="to-website sample-btn" :style="'color:'+item.btnColor">免费试用<i class="el-icon-right" :style="'color:'+item.btnColor"></i></a>
                <div class="left-box-icon"><img :class="item.isImageStyle" v-if="item.isImageUrl" :src="item.isImageUrl" /></div>
              </div>
            </div>
          </div>
        </section>
        <!--end 解决方案-->
        <!--star 更多适用功能-->
        <section class="section3 section">
          <h2 class="subheading" v-if="moreuseList.title">{{moreuseList.title}}</h2>
          <p class="subheading-1" v-if="moreuseList.desc">{{moreuseList.desc}}</p>
          <ul class="more-box anim-bottom-to-top" ref="boxSection3">
            <li v-for="item in moreuseList.list">
              <img :src="item.icon" />
              <span>{{item.title}}</span>
            </li>
          </ul>
        </section>
        <!--end 更多适用功能-->
        <!--star 优质服务保障-->
        <section class="section5 section">
          <h2 class="subheading" v-if="serviceList.title">{{serviceList.title}}</h2>
          <p class="subheading-1" v-if="serviceList.desc">{{serviceList.desc}}</p>
          <ul class="more-box anim-bottom-to-top" ref="boxSection5">
            <li v-for="item in serviceList.list">
              <img :src="item.icon" />
              <span>{{item.title}}</span>
              <p v-html="item.desc"></p>
            </li>
          </ul>
        </section>
        <!--end 优质服务保障-->
        <!--star 荣誉资质-->
        <section class="section6 section">
          <h2 class="subheading">{{honorList.title}}</h2>
          <div class="section6-mian flex-item-center">
            <div class="btn" @click="onLast()"><!--forbid-->
              <p style="transform: rotate(135deg)"></p>
            </div>
            <div class="img-box p-r">
              <div class="flex-item-center p-a" id="section-img" ref="sectionImg" :style="sectionImgStyle">
                <div class="section6-img" v-for="item in honorList.list">
                  <img :src="item.icon">
                </div>
              </div>
            </div>
            <div class="btn" @click="onNext()"><p></p></div>
          </div>
        </section>
        <!--end 荣誉资质-->
        <!--star 服务客户-->
        <section class="section7 section">
          <h2 class="subheading">服务客户</h2>
          <div class="section7-main p-r">
            <div class="p-a" style="width: 100%;height: 100px;top: 0;left: 0px;">
              <div class="line_odd">
                <img class="logo_img" src="https://www.yiguaerp.com/Assets/img/home/section7-1.png">
                <img class="logo_img" src="https://www.yiguaerp.com/Assets/img/home/section7-1.png">
              </div>
            </div>
            <div class="p-a" style="width: 100%;height: 100px;top: 130px;left: 0px;">
              <div class="line_odd-2" style="width:3962px;overflow: hidden;">
                <div style="width: 100%;overflow-x: hidden;"><img class="logo_img p-r"
                    style="width: 2229px;left: -248px;height: auto;" src="https://www.yiguaerp.com/Assets/img/home/section7-2.png">
                </div>
                <div style="width: 100%;overflow-x: hidden;"><img class="logo_img p-r"
                    style="width: 2229px;left: -248px;height: auto;" src="https://www.yiguaerp.com/Assets/img/home/section7-2.png">
                </div>
              </div>
            </div>
            <div class="p-a" style="width: 100%;height: 100px;top: 260px;left: 0px;">
              <div class="line_odd">
                <img class="logo_img" src="https://www.yiguaerp.com/Assets/img/home/section7-3.png">
                <img class="logo_img" src="https://www.yiguaerp.com/Assets/img/home/section7-3.png">
              </div>
            </div>
          </div>
        </section>
        <!--end 服务客户-->
      </div>

      <!--star footer -->
      <div class="footer">
        <div class="footer-box p-r">
          <img class="footer-logo" src="https://www.yiguaerp.com/Assets/img/footer-logo.png" />
          <p class="footer-title-1">关于我们</p>
          <p class="footer-desc">福州果集信息科技是社交媒体平台数据、产品与全链路服务提供商，致力于将大数据、AI等<br />新技术应用于社交媒体营销和电商领域，以数据和技术驱动品牌增长。</p>
          <p class="footer-place">
            <img src="https://www.yiguaerp.com/Assets/img/place.png" />
            <span>福建省福州市仓山区智能产业园A3栋11-14</span>
          </p>
          <p class="beian">Copyright © 2014-2023 果集·易瓜ERP | 福州果集信息科技有限公司 | <a target="_blank" class="text-link"
              href="https://beian.miit.gov.cn/">闽ICP备19018186号</a></p>
          <div class="p-a footer-service">
            <img class="service-qrcode" src="https://www.yiguaerp.com/Assets/img/service-qrcode.png">
            <p>扫码咨询客服</p>
          </div>
        </div>
      </div>
      <!--end footer-->

    </div>
    <!-- end容器 -->
</template>

<script>
export default {
  name: 'Home',
  components: {},
  data() {
    return {
      httpsUrl:'https://www.yiguaerp.com/',
      scrollTop: 0, //默认距离顶部的距离
      isTop:false,
      scrollTrigger: false, //默认初始值
      section1check: require('./images/section1check.png'),

      honorIndex:1,
      sectionImgStyle:{

      },

      navList:[
        {title:'易瓜ERP',url:''},
        {title:'易瓜打单',url:''}
      ],
      oneList:[
        {title:'打单发货',icon:'https://www.yiguaerp.com/Assets/img/home/deliverGoods.png'},
        {title:'商品成本',icon:'https://www.yiguaerp.com/Assets/img/home/cost.png'},
        {title:'库存采购',icon:'https://www.yiguaerp.com/Assets/img/home/purchase.png'},
        {title:'直播利润报表',icon:'https://www.yiguaerp.com/Assets/img/home/statement.png'},
      ],
      twoList:[
        {isHot:false,title:'多店统一管理', desc:'多平台无需频繁切换，面单共享', bigIcon:'https://www.yiguaerp.com/Assets/img/home/tabIcon1-1.png', samllIcon:'https://www.yiguaerp.com/Assets/img/home/tabIcon1.png'},
        {isHot:false,title:'高效打单发货', desc:'智能拆合订单，巨省快递费', bigIcon:'https://www.yiguaerp.com/Assets/img/home/tabIcon2-1.png', samllIcon:'https://www.yiguaerp.com/Assets/img/home/tabIcon2.png'},
        {isHot:false,title:'商品智能统计', desc:'支持统计商品多维度成本', bigIcon:'https://www.yiguaerp.com/Assets/img/home/tabIcon3-1.png', samllIcon:'https://www.yiguaerp.com/Assets/img/home/tabIcon3.png'},
        {isHot:false,title:'库存成本精准', desc:'库存精准扣增，成本一目了然', bigIcon:'https://www.yiguaerp.com/Assets/img/home/tabIcon4-1.png', samllIcon:'https://www.yiguaerp.com/Assets/img/home/tabIcon4.png'},
        {isHot:true,title:'直播利润报表', desc:'智能生成多平台店铺利润报表', bigIcon:'https://www.yiguaerp.com/Assets/img/home/tabIcon5-1.png', samllIcon:'https://www.yiguaerp.com/Assets/img/home/tabIcon5.png'},
      ],
      solutionList:{
        title:'功能齐全、降本增效，更多直播场景解决方案',
        contentList:[
          {
            ref:'boxSection201',
            layout:'left',
            leftClass:'left-box-1',
            rightClass:'right-box-1',
            title:'多平台多店铺 订单高效处理',
            icon:'',
            color:'',
            btnColor:'',
            list: ['多平台订单实时同步，秒速下载','自动拆合订单，智能匹配快递省钱省时','爆款打单，多维度组合自定义排序','售后扫描登记，退货入库有据可依','异常订单、退款、缺货等自动拦截'],
            image:'',
            imageHtml:'<img class="anim-bottom-to-top p-a" style="width: 609px;top: 52px;left: 50px;" src="https://www.yiguaerp.com/Assets/img/home/section2-1-1.png" /><img class="anim-left-to-right p-a shadow-img" style="width: 664px;top: 81px;left: 21px;" src="https://www.yiguaerp.com/Assets/img/home/section2-1-2.png" /><img class="anim-right-to-left p-a shadow-img" style="width: 260px;top: 268px;left: 34px;" src="https://www.yiguaerp.com/Assets/img/home/section2-1-3.png" /><img class="anim-bottom-to-left p-a shadow-img" style="width: 253px;top: 249px;left: 425px;" src="https://www.yiguaerp.com/Assets/img/home/section2-1-4.png" />',
            isImageUrl:null,
            isImageStyle:null
          },
          {
            ref:'boxSection202',
            layout:'right',
            leftClass:'left-box-2',
            rightClass:'right-box-2',
            title:'商品采购 库存精准统计',
            icon:'',
            color:'#222268',
            btnColor:'#7C48EE',
            list: ['库存精准实时同步，预防超卖','支持组合装自动扣增单品库存','快捷采购入库，分仓设置仓配流程','精准仓位规划管理，拣货更轻松高效','支持不同行业自定义商品多维成本'],
            image:[],
            imageHtml:' <img class="anim-left-to-right p-a" style="width: 553px;top: 82px;left: 78px;" src="https://www.yiguaerp.com/Assets/img/home/section2-2-1.png" /><img class="anim-right-to-left p-a shadow-img" style="width: 303px;top: 27px;left: 30px;" src="https://www.yiguaerp.com/Assets/img/home/section2-2-2.png" /><img class="anim-bottom-to-top p-a shadow-img" style="width: 437px;top: 333px;left: 250px;"src="https://www.yiguaerp.com/Assets/img/home/section2-2-3.png" />',
            isImageUrl:null,
            isImageStyle:null
          },
          {
            ref:'boxSection203',
            layout:'left',
            leftClass:'left-box-3',
            rightClass:'right-box-3',
            title:'创新店铺管理 数据化选品',
            icon:'',
            color:'#144147',
            btnColor:'#0EADC2',
            list: ['创新店铺模块，自动统计多店铺利润','店铺经营日报，轻松查看每日经营利润','店铺商品分析，商品多维数据助力选品','店铺直播记录，自动复盘直播利润'],
            image:[],
            imageHtml:'<img class="anim-bottom-to-top p-a bottom-to-top" style="width: 587px;top: 58px;left: 61px;" src="https://www.yiguaerp.com/Assets/img/home/section2-3-1.png"><img class="anim-left-to-right p-a shadow-img left-to-right" style="width: 657px;top: 30px;left: 26px;" src="https://www.yiguaerp.com/Assets/img/home/section2-3-2.png"><img class="anim-left-to-right p-a shadow-img left-to-right" style="width: 439px;top: 237px;left: 244px;" src="https://www.yiguaerp.com/Assets/img/home/section2-3-3.png">',
            isImageUrl:require('./images/functionIcon3-2.png'),
            isImageStyle:'p-a left-box-icon-1'
          },
          {
            ref:'boxSection204',
            layout:'right',
            leftClass:'left-box-4',
            rightClass:'right-box-4',
            title:'智能报表 助力提升直播利润',
            icon:'',
            color:'#001560',
            btnColor:'',
            list: ['新增集团视角，多平台多店铺经营利润自动统计','商品多维度数据分析，福利款、利润款选品更科学','多模式统计快递成本，分店统计快递费用','特色直播报表，自动统计每场直播利润','跟进直播新玩法，持续创新更多报表'],
            image:[],
            imageHtml:'<img class="anim-bottom-to-top p-a bottom-to-top" style="width: 587px;top: 58px;left: 61px;" src="https://www.yiguaerp.com/Assets/img/home/section2-4-1.png"><img class="anim-right-to-left p-a shadow-img right-to-left" style="width: 396px;top: 258px;left: 291px;" src="https://www.yiguaerp.com/Assets/img/home/section2-4-3.png">',
            isImageUrl:require('./images/functionIcon4-2.png'),
            isImageStyle:'p-a left-box-icon-2'
          },
          {
            ref:'boxSection205',
            layout:'left',
            leftClass:'left-box-5',
            rightClass:'right-box-5',
            title:'团队管理 管理更安全',
            icon:'',
            color:'#222268',
            btnColor:'#7C48EE',
            list: ['支持添加多个子账号','可设置多级操作权限','员工流动管理更安全'],
            image:[],
            imageHtml:'<img class="anim-bottom-to-top p-a bottom-to-top" style="width: 587px;top: 54px;left: 61px;" src="https://www.yiguaerp.com/Assets/img/home/section2-5-1.png"><img class="anim-left-to-right p-a shadow-img left-to-right" style="width: 119px;top: 259.5px;left: 40px;" src="https://www.yiguaerp.com/Assets/img/home/section2-5-2.png"><img class="anim-right-to-left p-a shadow-img right-to-left" style="width: 442px;top: 211.5px;left: 252px;" src="https://www.yiguaerp.com/Assets/img/home/section2-5-3.png">',
            isImageUrl:require('./images/functionIcon5-2.png'),
            isImageStyle:'p-a left-box-icon-2'
          },
        ]
      },
      moreuseList:{
        title:'更多适用功能',
        desc:'充分满足直播商家需求，打单轻松易售上手',
        list:[
          {title:'订单审核',icon:require('./images/moreuse-1.png')},
          {title:'订单发货',icon:require('./images/moreuse-2.png')},
          {title:'售后管理',icon:require('./images/moreuse-3.png')},
          {title:'线下店铺',icon:require('./images/moreuse-4.png')},
          {title:'商品同步',icon:require('./images/moreuse-5.png')},
          {title:'供应商管理',icon:require('./images/moreuse-6.png')},
          {title:'采购入库',icon:require('./images/moreuse-7.png')},
          {title:'库存分仓',icon:require('./images/moreuse-8.png')},
          {title:'直播数据',icon:require('./images/moreuse-9.png')},
          {title:'更多',icon:require('./images/moreuse-10.png')}
        ]
      },
      serviceList:{
        title:'优质服务保障',
        desc:'用心服务每一个用户',
        list:[
          {title:'快速响应',desc:'向每位用户提供<br/>软件服务和帮助',icon:require('./images/service-1.png')},
          {title:'快速响应',desc:'向每位用户提供<br/>软件服务和帮助',icon:require('./images/service-2.png')},
          {title:'快速响应',desc:'向每位用户提供<br/>软件服务和帮助',icon:require('./images/service-3.png')},
          {title:'快速响应',desc:'向每位用户提供<br/>软件服务和帮助',icon:require('./images/service-4.png')},
        ]
      },
      honorList:{
        title:'荣誉资质',
        list:[
          {icon:require('./images/honor-1.png')},
          {icon:require('./images/honor-1.png')},
          {icon:require('./images/honor-1.png')},
          {icon:require('./images/honor-1.png')},
          {icon:require('./images/honor-1.png')},
          {icon:require('./images/honor-1.png')},
          {icon:require('./images/honor-1.png')},
          {icon:require('./images/honor-1.png')},
          {icon:require('./images/honor-1.png')},
          {icon:require('./images/honor-1.png')}
        ]
      }
    }
  },
  methods: {
    //滚动监听
    handleScroll() {
      let vm = this
      let h = window.innerHeight;
      let top = this.$refs.scrollcontainer.scrollTop
      let S2Top = this.$refs.boxSection2.children;
      let S3Top = this.$refs.boxSection3
      let S5Top = this.$refs.boxSection5
      if(top){
        if (top > 0) {
          this.isTop = true
          const scrollPosition = top + h;
          for (var i = 0; i < S2Top.length; i++) {
              var child = S2Top[i];
              if(scrollPosition >= child.offsetTop + 640){
                child.classList.add("anim-section2-show")
              }else{
                child.classList.remove("anim-section2-show")
              }
          }
          if (scrollPosition >= S3Top.offsetTop) {
            S3Top.classList.add('bottom-to-top');
          }else{
            S3Top.classList.remove('bottom-to-top');
          }
          if (scrollPosition >= S5Top.offsetTop) {
            S5Top.classList.add('bottom-to-top');
          }else{
            S5Top.classList.remove('bottom-to-top');
          }
        } else {
          this.isTop = false
        }
      }
    },
    //返回顶部
    onBackTop(){
      this.$refs.scrollcontainer.scrollTop = 0;
    },
    //点击上一个
    onLast(){
      if (this.honorIndex !==0) {
        this.honorIndex--;
        this.sectionImgStyle = {
          ...this.sectionImgStyle,
          left:-245 * this.honorIndex + 'px'
        };
      }
    },
    //点击下一个
    onNext(){
      if(this.honorIndex < (this.honorList.list.length - 5)){
        this.honorIndex++;
        this.sectionImgStyle = {
          ...this.sectionImgStyle,
          left:-245 * this.honorIndex + 'px'
        };
      }
    },
  },
  created () {
    let h = window.innerHeight;
    document.documentElement.style = 'height:' + h + 'px';
    window.addEventListener("scroll", this.handleScroll, true);
  },
  destroyed () {
    window.removeEventListener("scroll", this.handleScroll, false);
  },
}
</script>

<style lang="scss" scoped>
@import url('./webHome.scss');
</style>
