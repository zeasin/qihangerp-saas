<template>
  <div class="app-container">
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="线下渠道" name="printOffline">
        <print-offline></print-offline>
      </el-tab-pane>
      <el-tab-pane label="微信小店" name="printWei" lazy>
        <print-wei></print-wei>
      </el-tab-pane>
      <el-tab-pane label="拼多多" name="printPdd" lazy>
        <print-pdd></print-pdd>
      </el-tab-pane>


    </el-tabs>

  </div>
</template>

<script>
import printOffline  from "@/views/shipping/ewaybillPrint/offline.vue";
import printWei  from "@/views/shipping/ewaybillPrint/wei.vue";
import printPdd from "@/views/shipping/ewaybillPrint/pdd.vue";


export default {
  name: "print",
  components:{printWei,printPdd,printOffline},
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
