<template>
  <div class="app-container">
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="退货" name="returned">
        <after-sale-returned></after-sale-returned>
      </el-tab-pane>
      <el-tab-pane label="换货" name="exchange" lazy>
        <after-sale-exchange></after-sale-exchange>
      </el-tab-pane>
      <el-tab-pane label="订单拦截" name="intercept" lazy>
        <after-sale-intercept></after-sale-intercept>
      </el-tab-pane>
      <el-tab-pane label="订单补发" name="offlineRefund" lazy>
        <after-sale-ship-again></after-sale-ship-again>
      </el-tab-pane>



    </el-tabs>

  </div>
</template>

<script>

import AfterSaleReturned  from "@/views/afterSale/returned/index";
import AfterSaleExchange  from "@/views/afterSale/exchange/index";
import AfterSaleIntercept  from "@/views/afterSale/intercept/index";
import AfterSaleShipAgain  from "@/views/afterSale/shipAgain/index";
export default {
  name: "OrderAfterSale",
  components:{AfterSaleReturned,AfterSaleExchange,AfterSaleIntercept,AfterSaleShipAgain},
  data() {
    return {
      activeName: 'returned'
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
