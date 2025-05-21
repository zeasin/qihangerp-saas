<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="108px">
      <el-form-item label="店铺" prop="shopId">
        <el-select v-model="queryParams.shopId" placeholder="请选择店铺" clearable @change="handleQuery">
          <el-option
            v-for="item in shopList"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="平台SkuId" prop="skuId">
        <el-input
          v-model="queryParams.skuId"
          placeholder="请输入平台SkuId"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="商家sku编码" prop="outerId">
        <el-input
          v-model="queryParams.outerId"
          placeholder="请输入商家sku编码"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="ERP skuId" prop="erpSkuId">
        <el-input
          v-model="queryParams.erpSkuId"
          placeholder="请输入ERP skuId"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>

      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          :loading="pullLoading"
          icon="el-icon-download"
          size="mini"
          @click="handlePull"
        >API拉取商品数据</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-refresh"
          size="mini"
          :disabled="multiple"
          @click="handlePushOms"
        >批量推送到商品库</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="goodsList" @selection-change="handleSelectionChange">
       <el-table-column type="selection" width="55" align="center" />
<!--      <el-table-column label="ID" align="center" prop="id" />-->
      <el-table-column label="商品标题" align="left" prop="title" />
      <el-table-column label="平台商品ID" align="left" prop="productId" width="150px" />
<!--      <el-table-column label="主图" align="center" prop="headImg" width="100">-->
<!--        <template slot-scope="scope">-->
<!--          <image-preview :src="scope.row.headImg" :width="50" :height="50"/>-->
<!--        </template>-->
<!--      </el-table-column>-->
      <el-table-column label="店铺" align="center" prop="shopId" width="150px">
        <template slot-scope="scope">
          <el-tag size="small">{{shopList.find(x=>x.id == scope.row.shopId)?shopList.find(x=>x.id == scope.row.shopId).name:''}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="Sku明细" align="center" width="800px" >
        <template slot="header">
          <table>
            <th>
              <td width="50px">图片</td>
              <td width="100px" align="left">平台SkuId</td>
              <td width="100px" align="left">商品库SkuId</td>
              <td width="100" align="left">规格</td>
              <td width="100" align="left">Sku编码</td>
              <td width="100" align="left">库存</td>
              <td width="100" align="left">状态</td>
              <td width="120" align="left">操作</td>
            </th>
          </table>
        </template>
        <template slot-scope="scope" >
          <el-table :data="scope.row.skus" :show-header="false" :cell-style="{border:0 + 'px' }"  :row-style="{border:0 + 'px' }" >
            <el-table-column label="图片" width="50px">
              <template slot-scope="scope">
                <!--                <el-image  style="width: 40px; height: 40px;" :src="scope.row.goodsImg" :preview-src-list="[scope.row.goodsImg]"></el-image>-->
                <image-preview :src="scope.row.thumbImg" :width="40" :height="40"/>
              </template>
            </el-table-column>
            <el-table-column label="SkuId" align="left" width="100px" prop="skuId" ></el-table-column>
            <el-table-column label="SkuId" align="left" width="100px" prop="erpGoodsSkuId" ></el-table-column>

            <el-table-column label="规格" align="left" prop="goodsSpec" width="100">
              <template slot-scope="scope">
                {{ getSkuValues(scope.row.skuAttrs)}}
              </template>
            </el-table-column>
            <el-table-column label="Sku编码" align="left" prop="skuCode" width="100"/>
            <el-table-column label="库存" align="left" prop="stockNum" width="100"/>
            <el-table-column label="状态" align="center" prop="status" width="100">
                <template slot-scope="scope">
                  <el-tag size="small" v-if="scope.row.status === 5">销售中</el-tag>
                  <el-tag size="small" v-if="scope.row.status === 6">回收站</el-tag>
                  <el-tag size="small" v-if="scope.row.status === 9">彻底删除</el-tag>
                  <el-tag size="small" v-if="scope.row.status === 11">自主下架</el-tag>
                  <el-tag size="small" v-if="scope.row.status === 13">违规下架</el-tag>
                  <el-tag size="small" v-if="scope.row.status === 14">保证金不足下架</el-tag>
                  <el-tag size="small" v-if="scope.row.status === 15">品牌过期下架</el-tag>
                  <el-tag size="small" v-if="scope.row.status === 20">商品被封禁</el-tag>
                </template>
            </el-table-column>
            <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="120">
              <template slot-scope="scope">
                <el-button
                  size="mini"
                  type="text"
                  icon="el-icon-edit"
                  @click="handleLink(scope.row)"
                >关联ERP</el-button>

              </template>
            </el-table-column>
          </el-table>
        </template>
      </el-table-column>
<!--       <el-table-column label="属性" align="center" prop="attrs" >-->
<!--         <template slot-scope="scope">-->
<!--&lt;!&ndash;           {{scope.row.attrs}}&ndash;&gt;-->
<!--           <el-row v-for="item in JSON.parse(scope.row.attrs)" :key="item.attr_key" :gutter="20">-->
<!--             <div style="float: left;display: flex;align-items: center;" >-->
<!--               <div style="margin-left:10px">-->
<!--                 {{item.attr_key}}：{{item.attr_value}}&nbsp;-->
<!--               </div>-->
<!--             </div>-->
<!--           </el-row>-->
<!--         </template>-->
<!--       </el-table-column>-->
      <el-table-column label="状态" align="center" prop="status" >
        <template slot-scope="scope">
          <el-tag size="small" v-if="scope.row.status === 5">销售中</el-tag>
          <el-tag size="small" v-if="scope.row.status === 6">回收站</el-tag>
          <el-tag size="small" v-if="scope.row.status === 9">彻底删除</el-tag>
          <el-tag size="small" v-if="scope.row.status === 11">自主下架</el-tag>
          <el-tag size="small" v-if="scope.row.status === 13">违规下架</el-tag>
          <el-tag size="small" v-if="scope.row.status === 14">保证金不足下架</el-tag>
          <el-tag size="small" v-if="scope.row.status === 15">品牌过期下架</el-tag>
          <el-tag size="small" v-if="scope.row.status === 20">商品被封禁</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="tenant" align="center" prop="tenantId" v-if="isAdmin"/>
<!--      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">-->
<!--        <template slot-scope="scope">-->
<!--          <el-button-->
<!--            size="mini"-->
<!--            type="text"-->
<!--            icon="el-icon-edit"-->
<!--            @click="handleLink(scope.row)"-->
<!--          >关联ERP</el-button>-->

<!--        </template>-->
<!--      </el-table-column>-->
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />


    <!-- 添加或修改商品管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="ERP商品SkuId" prop="erpSkuId">
          <el-input v-model.number="form.erpSkuId" placeholder="请输入ERP商品SkuId" />
        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import '@riophae/vue-treeselect/dist/vue-treeselect.css'
import { listGoods, getGoods, delGoods, addGoods, updateGoods,pullGoodsList,pushToErp } from "@/api/shop/goods";
import {listShop} from "@/api/shop/shop";
import {getUserProfile} from "@/api/system/user";

export default {
  name: "GoodsWei",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      isAdmin: false,
      pullLoading: false,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 商品管理表格数据
      goodsList: [],
      shopList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        name: null,
        shopType: 5,
      },
      // 表单参数
      form: {},
      supplierList: [],
      categoryList: [],
      categoryTree: [],
      // 表单校验
      rules: {
        id: [
          { required: true, message: "不能为空", trigger: "change" }
        ],
        erpSkuId: [
          { required: true, message: "不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    getUserProfile().then(resp=>{
      this.isAdmin = resp.data.admin
    })
    listShop({type:5}).then(response => {
      this.shopList = response.rows;
      if (this.shopList && this.shopList.length > 0) {
        this.queryParams.shopId = this.shopList[0].id
      }
      this.getList();
    });

    // this.loading = false;
  },
  methods: {
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    getSkuValues(spec){
      try {
        // 解析 JSON，返回一个数组
        const parsedSpec = JSON.parse(spec) || [];

        // 使用 map 提取所有 value，使用 join() 用逗号连接
        return parsedSpec.map(item => item.attr_value || item.value).join(', ') || '';
      } catch (error) {
        return spec; // 如果 JSON 解析出错，返回空字符串
      }
    },
    /** 查询商品管理列表 */
    getList() {
      this.loading = true;
      listGoods(this.queryParams).then(response => {
        this.goodsList = response.rows;
        this.total = response.total;
        this.loading = false;
      });

    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        erpSkuId: null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    handleLink(row) {
      this.reset();
      const id = row.id || this.ids
      getGoodsSku(id).then(response => {
        console.log('=====00000000============',response)
        this.form = response.data;
        this.open = true;
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          linkErpGoodsSkuId(this.form).then(response => {
            this.$modal.msgSuccess("关联成功");
            this.open = false;
            this.getList();
          });
        }
      });
    },
    handlePull() {
      if(this.queryParams.shopId){
        this.pullLoading = true
        pullGoodsList({shopId:this.queryParams.shopId}).then(response => {
          console.log('拉取视频号小店商品接口返回=====',response)
          if(response.code === 1401) {
            MessageBox.confirm('Token已过期，需要重新授权', '系统提示', { confirmButtonText: '重新授权', cancelButtonText: '取消', type: 'warning' }).then(() => {
              isRelogin.show = false;
              // store.dispatch('LogOut').then(() => {
              location.href = response.data.tokenRequestUrl+'?shopId='+this.queryParams.shopId
              // })
            }).catch(() => {
              isRelogin.show = false;
            });

            // return Promise.reject('无效的会话，或者会话已过期，请重新登录。')
          }else if(response.code === 1001) {
            this.$modal.msgSuccess(JSON.stringify(response));
          }else{
            this.$modal.msgSuccess(JSON.stringify(response));
            this.pullLoading = false
            this.getList()
          }


          this.pullLoading = false
        })
      }else{
        this.$modal.msgSuccess("请先选择店铺");
      }

      // this.$modal.msgSuccess("请先配置API");
    },
    //推送店铺商品到OMS
    handlePushOms(){
      this.$confirm('确认同步所有商品到商品库吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        pushToErp( this.ids ).then(response => {
          this.$message.success('商品同步成功')
          this.getList()
        }).finally(() => {
          this.loading = false
        })
      })

    },
  }
};
</script>
