<template>
  <div class="app-container">

    <el-tabs v-model="activeName" @tab-click="handleClick" type="border-card">
      <el-tab-pane label="待发货订单" name="LogisticsCompany" >
       <wait-shipment-pdd></wait-shipment-pdd>
      </el-tab-pane>
      <el-tab-pane label="已发货订单" name="EwaybillAccount" lazy>
        <shipped-list-wei></shipped-list-wei>
      </el-tab-pane>
    </el-tabs>

  </div>
</template>

<script>
import WaitShipmentPdd from "@/views/shipping/send/print_shipment/wei/print_list.vue";
import ShippedListWei from "@/views/shipping/send/print_shipment/wei/shipped_list.vue";

export default {
  name: "PrintShipmentWei",
  components:{
    WaitShipmentPdd,ShippedListWei
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
