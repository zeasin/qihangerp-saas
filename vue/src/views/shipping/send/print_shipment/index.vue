<template>
  <div class="app-container">
    <el-row>
      <el-col span="6">
        <div style="color: #fff">&nbsp;电子面单发货</div>
      </el-col>
      <el-col span="12">
        <el-steps :active="0"   finish-status="success">
          <el-step title="拉取店铺电子面单账户" >
            <template slot="description">
              <el-button size="mini" @click="$router.push('/ship/setting?tag=EwaybillAccount')">去拉取</el-button>
            </template>
          </el-step>
          <el-step title="设置发货地址" >
            <template slot="description">
              <el-button size="mini" @click="$router.push('/ship/setting?tag=EwaybillAccount')">去设置</el-button>
            </template>
          </el-step>
          <el-step title="安装云打印组件" >
            <template slot="description">

            </template>
          </el-step>
          <el-step title="设置快递模版" description="用来获取快递单和打印快递"></el-step>
        </el-steps>
      </el-col>
      <el-col span="6">
      </el-col>
    </el-row>
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
