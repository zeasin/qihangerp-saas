<template>
  <div class="app-container">
    <el-row>
      <el-col span="6">
        <div style="color: #fff">&nbsp;电子面单发货</div>
      </el-col>
      <el-col span="12">
        <el-steps :active="2"   finish-status="success">
          <el-step title="拉取店铺商品" >

          </el-step>
          <el-step title="推送到商品库" >
          </el-step>
          <el-step title="或者手动关联商品库" >
          </el-step>

        </el-steps>
      </el-col>
      <el-col span="6">
      </el-col>
    </el-row>
    <el-tabs v-model="activeName" @tab-click="handleClick">

      <el-tab-pane label="线下渠道" name="offlineGoods" lazy>
        <goods-offline></goods-offline>
      </el-tab-pane>

      <el-tab-pane label="微信小店" name="weiGoods" lazy>
        <goods-wei></goods-wei>
      </el-tab-pane>
      <el-tab-pane label="拼多多" name="pddGoods" lazy>
        <goods-pdd></goods-pdd>
      </el-tab-pane>

<!--      <el-tab-pane label="小红书" name="xhsGoods" lazy>-->
<!--        开发中-->
<!--      </el-tab-pane>-->
    </el-tabs>

  </div>
</template>

<script>

import GoodsOffline  from "@/views/shop/goods/offline/index";
import GoodsPdd  from "@/views/shop/goods/pdd/index";
import GoodsWei  from "@/views/shop/goods/wei/index";
export default {
  name: "ShopGoods",
  components:{GoodsOffline,GoodsPdd,GoodsWei},
  data() {
    return {
      activeName: 'offlineGoods'
    };
  },
  created() {

  },
  mounted() {

  },
  methods: {
    handleClick(tab, event) {
      console.log(tab, event);
    }
  }
};
</script>
