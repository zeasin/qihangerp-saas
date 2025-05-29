<template>
  <div class="app-container">

    <el-tabs v-model="activeName" @tab-click="handleClick" type="border-card">
      <el-tab-pane label="待发货订单" name="LogisticsCompany" >
       <wait-shipment-pdd></wait-shipment-pdd>
      </el-tab-pane>
      <el-tab-pane label="已发货订单" name="EwaybillAccount" lazy>
        <goods-sku-pdd></goods-sku-pdd>
      </el-tab-pane>
    </el-tabs>

  </div>
</template>

<script>
import WaitShipmentPdd from "@/views/shipping/send/print_shipment/wei/print_list.vue";
import GoodsSkuPdd from "@/views/shop/goods/pdd/goods_sku.vue";

export default {
  name: "PrintShipmentWei",
  components:{
    WaitShipmentPdd,GoodsSkuPdd
  },
  data() {
    return {
      activeName: 'LogisticsCompany',
      typeList: [],
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
