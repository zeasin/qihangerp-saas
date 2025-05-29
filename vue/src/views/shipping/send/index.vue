<template>
  <div class="app-container">
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="手动发货" name="printOffline">
        <manual-shipment></manual-shipment>
      </el-tab-pane>
      <el-tab-pane label="电子面单发货" name="printWei" lazy>
        <print-shipment></print-shipment>
      </el-tab-pane>



    </el-tabs>

  </div>
</template>

<script>
import ManualShipment  from "@/views/shipping/send/manual_shipment.vue";
import PrintShipment  from "@/views/shipping/send/print_shipment/index.vue";



export default {
  name: "Shipment",
  components:{PrintShipment,ManualShipment},
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
