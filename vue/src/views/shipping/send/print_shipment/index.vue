<template>
  <div class="app-container">

    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="拼多多" name="LogisticsCompany" >
       <print-shipment-pdd></print-shipment-pdd>
      </el-tab-pane>
      <el-tab-pane label="微信小店" name="EwaybillAccount" lazy>
        <print-shipment-wei></print-shipment-wei>
      </el-tab-pane>
    </el-tabs>

  </div>
</template>

<script>
import PrintShipmentPdd from "@/views/shipping/send/print_shipment/pdd/index.vue";
import PrintShipmentWei from "@/views/shipping/send/print_shipment/wei/index.vue";

export default {
  name: "PrintShipment",
  components:{
    PrintShipmentPdd,PrintShipmentWei
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
