<template>
  <div class="app-container">
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="拼多多" name="pddRefund">
        <refund-pdd></refund-pdd>
      </el-tab-pane>
      <el-tab-pane label="微信小店" name="weiRefund" lazy>
        <refund-wei></refund-wei>
      </el-tab-pane>
      <el-tab-pane label="线下渠道" name="offlineRefund" lazy>
        <refund-offline></refund-offline>
      </el-tab-pane>




    </el-tabs>

  </div>
</template>

<script>

import RefundOffline  from "@/views/shop/refund/offline/index";
import RefundPdd  from "@/views/shop/refund/pdd/index";
import RefundWei  from "@/views/shop/refund/wei/index";
export default {
  name: "ShopRefund",
  components:{RefundOffline,RefundPdd,RefundWei},
  data() {
    return {
      activeName: 'pddRefund'
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
