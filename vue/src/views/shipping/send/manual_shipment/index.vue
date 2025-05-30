<template>
  <div class="app-container">
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="待发货" name="printOffline">
        <shipment-wait></shipment-wait>
      </el-tab-pane>
      <el-tab-pane label="已发货" name="printWei" lazy>
        <shipment-shipped></shipment-shipped>
      </el-tab-pane>



    </el-tabs>

  </div>
</template>

<script>
import ShipmentWait  from "@/views/shipping/send/manual_shipment/wait_ship.vue";
import ShipmentShipped  from "@/views/shipping/send/manual_shipment/shipped_list.vue";

export default {
  name: "Shipment",
  components:{ShipmentWait,ShipmentShipped},
  data() {
    return {
      activeName: 'printOffline'
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
