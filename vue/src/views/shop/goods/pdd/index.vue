<template>
  <div class="app-container">
    <el-tabs v-model="activeName" @tab-click="handleClick" type="border-card">
      <el-tab-pane label="店铺商品" name="LogisticsCompany" >
       <goods-list-pdd></goods-list-pdd>
      </el-tab-pane>
      <el-tab-pane label="店铺商品SKU" name="EwaybillAccount" lazy>
        <goods-sku-pdd></goods-sku-pdd>
      </el-tab-pane>
    </el-tabs>

  </div>
</template>

<script>
import GoodsListPdd from "@/views/shop/goods/pdd/goods_list.vue";
import GoodsSkuPdd from "@/views/shop/goods/pdd/goods_sku.vue";

export default {
  name: "GoodsPdd",
  components:{
    GoodsListPdd,GoodsSkuPdd
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
