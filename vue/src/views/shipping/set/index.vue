<template>
  <div class="app-container">
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="快递公司设置" name="LogisticsCompany" >
        <logistics-company></logistics-company>
      </el-tab-pane>
      <el-tab-pane label="电子面单账户设置" name="EwaybillAccount" lazy>
        <shop-waybill-account></shop-waybill-account>
      </el-tab-pane>
    </el-tabs>

  </div>
</template>

<script>
import LogisticsCompany from "@/views/shipping/set/company.vue";
import ShopWaybillAccount from "@/views/shipping/set/shop_ewaybill_account.vue"
export default {
  name: "set",
  components:{
    LogisticsCompany,ShopWaybillAccount
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
