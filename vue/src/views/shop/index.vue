<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="店铺名" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入店铺名"
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
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['shop:shop:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['shop:shop:edit']"
        >修改</el-button>
      </el-col>

      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="shopList" @selection-change="handleSelectionChange">
<!--      <el-table-column type="selection" width="55" align="center" />-->
<!--      <el-table-column label="店铺ID" align="center" prop="id" />-->
      <el-table-column label="店铺名" align="center" prop="name" />
      <el-table-column label="平台" align="center" prop="type" >
        <template slot-scope="scope">
          <el-tag v-if="scope.row.type===3">拼多多</el-tag>
          <el-tag v-if="scope.row.type===5">微店小店</el-tag>
          <el-tag v-if="scope.row.type===9">其他渠道</el-tag>
        </template>
      </el-table-column>

       <el-table-column label="店铺卖家ID" align="center" prop="sellerId" />
       <el-table-column label="appKey" align="left" prop="appKey" />
       <el-table-column label="appSercet" align="left" prop="appSercet" />
<!--       <el-table-column label="accessToken" align="center" prop="accessToken" />-->
      <el-table-column label="描述" align="center" prop="remark" />
      <el-table-column label="租户" v-if="userId===1" align="center" prop="tenantId" />
      <el-table-column label="操作" v-if="userId>1" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-row>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['shop:shop:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['shop:shop:remove']"
          >删除</el-button>
          </el-row>

        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改店铺对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="店铺名" prop="name">
          <el-input v-model="form.name" placeholder="请输入店铺名" />
        </el-form-item>
        <el-form-item label="平台" prop="type">
          <el-select v-model="form.type" placeholder="请选择平台">
            <el-option label="微信小店" value="5"></el-option>
            <el-option label="拼多多" value="3"></el-option>
           <el-option label="其他渠道" value="9" ></el-option>


          </el-select>
        </el-form-item>
        <el-form-item label="appId" prop="appKey">
          <el-input v-model="form.appKey" placeholder="请输入appId" />
        </el-form-item>
        <el-form-item label="appSercet" prop="appSercet">
          <el-input v-model="form.appSercet" placeholder="请输入appSercet" />
        </el-form-item>

        <el-form-item label="卖家店铺ID" prop="sellerId">
          <el-input v-model="form.sellerId" placeholder="请输入卖家店铺ID" />
        </el-form-item>

        <el-form-item label="描述" prop="remark">
          <el-input type="textarea" v-model="form.remark" placeholder="请输入描述" />
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
import { listShop,listPlatform, getShop, delShop, addShop, updateShop } from "@/api/shop/shop";
import {getUserProfile} from "@/api/system/user";

export default {
  name: "Shop",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      userId: 0,
      // 店铺表格数据
      shopList: [],
      typeList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      apiOpen: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        name: null,
        type: null
      },
      // 表单参数
      form: {
        type: '5'
      },
      // 表单校验
      rules: {
        name: [{ required: true, message: "店铺名不能为空", trigger: "blur" }],
        type: [{ required: true, message: "不能为空", trigger: "blur" }],
        appKey: [{ required: true, message: "不能为空", trigger: "change" }],
        appSercet: [{ required: true, message: "不能为空", trigger: "change" }],
      }
    };
  },
  created() {
    getUserProfile().then(resp=>{
      this.userId = resp.data.userId;
    })
    this.getList();
  },
  methods: {
    /** 查询店铺列表 */
    getList() {
      this.loading = true;
      listShop(this.queryParams).then(response => {
        this.shopList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.apiOpen = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        name: null,
        nickName: null,
        ename: null,
        company: null,
        type: null,
        url: null,
        orderNum: null,
        isDelete: null,
        isShow: null,
        modifyOn: null,
        remark: null,
        sellerUserId: null,
        sellerUserIdStr: null,
        sessionKey: null,
        appkey: null,
        appSercet: null
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
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加店铺";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getShop(id).then(response => {
        this.form = response.data;
        this.$nextTick(()=>{
          this.form.type = response.data.type+'';
        })

        this.open = true;
        this.title = "修改店铺";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateShop(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.apiOpen = false
              this.getList();
            });
          } else {
            addShop(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$modal.confirm('是否确认删除店铺编号为"' + ids + '"的数据项？').then(function() {
        return delShop(row.id);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    }
  }
};
</script>
