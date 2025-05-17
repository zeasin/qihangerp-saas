<template>
  <div class="app-container">
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="仓库备货清单" name="stockShip">
        <stock-shipment-item></stock-shipment-item>

      </el-tab-pane>
      <el-tab-pane label="供应商发货订单" name="supplierShip" lazy>
        <supplier-ship-order></supplier-ship-order>
      </el-tab-pane>
    </el-tabs>

  </div>
</template>

<script>
import stockShipmentItem  from "@/views/shipping/stock_up/stockShipmentItem.vue";
import supplierShipOrder  from "@/views/shipping/stock_up/supplierShipOrder.vue";

export default {
  name: "stocking",
  components:{stockShipmentItem,supplierShipOrder},
  data() {
    return {
      activeName: 'stockShip'
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
