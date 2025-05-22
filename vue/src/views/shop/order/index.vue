<template>
  <div class="app-container">
    <el-tabs v-model="activeName" @tab-click="handleClick">

      <el-tab-pane label="线下渠道" name="offlineGoods" lazy>
        <order-offline></order-offline>
      </el-tab-pane>

      <el-tab-pane label="微信小店" name="weiGoods" lazy>
        <order-wei></order-wei>
      </el-tab-pane>
      <el-tab-pane label="拼多多" name="pddGoods" lazy>
        <order-pdd></order-pdd>
      </el-tab-pane>

<!--      <el-tab-pane label="小红书" name="xhsGoods" lazy>-->
<!--        开发中-->
<!--      </el-tab-pane>-->
    </el-tabs>

  </div>
</template>

<script>

import OrderOffline  from "@/views/shop/order/offline/index";
import OrderPdd  from "@/views/shop/order/pdd/index";
import OrderWei  from "@/views/shop/order/wei/index";
export default {
  name: "ShopOrder",
  components:{OrderOffline,OrderPdd,OrderWei},
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
