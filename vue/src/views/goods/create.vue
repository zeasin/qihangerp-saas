<template>
  <div class="app-container">
    <el-form ref="form" :model="form" :rules="rules" label-width="108px">

        <el-form-item label="商品分类" prop="categoryId">
          <treeselect :options="categoryList" placeholder="请选择上级菜单" v-model="form.categoryId" @select="categoryChange" style="width:220px"/>
        </el-form-item>
        <el-form-item label="供应商" prop="supplierId">
          <!-- <el-input v-model="form.supplierId" placeholder="请输入供应商id" /> -->
          <el-select v-model="form.supplierId" filterable  placeholder="请选择供应商名称">
            <el-option v-for="item in supplierList" :key="item.id" :label="item.name" :value="item.id">
          </el-option>
        </el-select>
        </el-form-item>
        <el-form-item label="商品名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入商品名称" />
        </el-form-item>
<!--        <el-form-item label="商品图片" prop="image">-->
<!--           <image-upload v-model="form.image" :limit="1"/>-->
<!--           <el-input v-model="form.image" placeholder="请输入商品图片" />-->
<!--        </el-form-item>-->
        <el-form-item label="商品编号" prop="number" >
          <el-input v-model="form.number" placeholder="请输入商品编号" style="width:220px"/>
        </el-form-item>
         <el-form-item label="预计采购价格" prop="purPrice">
          <el-input type="number" v-model.number="form.purPrice" placeholder="请输入预计采购价格" style="width:220px"/>
        </el-form-item>
        <el-form-item label="建议批发价" prop="wholePrice">
          <el-input type="number" v-model.number="form.wholePrice" placeholder="请输入建议批发价" style="width:220px"/>
        </el-form-item>
        <el-form-item label="建议零售价" prop="retailPrice">
          <el-input type="number" v-model.number="form.retailPrice" placeholder="请输入建议零售价" style="width:220px"/>
        </el-form-item>
        <el-form-item label="单位名称" prop="unitName">
          <el-input v-model="form.unitName" placeholder="请输入单位名称" style="width:220px" />
        </el-form-item>
        <el-form-item label="条码" prop="barCode">
          <el-input v-model="form.barCode" placeholder="请输入条码" style="width:220px"/>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="外链url" prop="linkUrl">
          <el-input v-model="form.linkUrl" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="发货地" prop="provinces">
          <el-cascader style="width:250px"
            size="large"
            :options="pcaTextArr"
            v-model="form.provinces">
          </el-cascader>
        </el-form-item>
        <el-form-item label="商品规格">
          <el-row :gutter="10" class="mb8" >
            <el-col :span="1.5" style="width: 56px">颜色：</el-col>
            <el-col :span="20">
              <treeselect :options="colorList" placeholder="颜色" v-model="form.colorValues" :normalizer="normalizer"  @input="onSpecChange" :multiple="true" />
            </el-col>
          </el-row>
          <el-row :gutter="10" class="mb8" >

            <el-col :span="24" style="margin-left: 60px;">
              <ul style=" display: flex;list-style: none;padding: 0;">
                <li v-for="color in form.colorValues" :key="color" style="margin-left: 20px;">
                  <el-upload
                    class="avatar-uploader"
                    :action="uploadImgUrl"
                    :show-file-list="false"
                    :headers="headers"
                    :on-success="(response, file, fileList) =>
                handleUploadSuccess(
                  response,
                  file,
                  fileList,
                  color
                )
            "
                    :before-upload="handleBeforeUpload">
                    <img v-if="form.colorImages[color]" :src="form.colorImages[color]" class="avatar">
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                  </el-upload>
                  <span>{{form.colorNames[color]}}</span>
                </li>
              </ul>

            </el-col>
          </el-row>
          <el-row :gutter="10" class="mb8" >
            <el-col :span="1.5" style="width: 60px">尺码：</el-col>
            <el-col :span="20">
              <treeselect :options="sizeList" placeholder="尺码" v-model="form.sizeValues" :normalizer="normalizer" @input="onSpecChange" :multiple="true" />
            </el-col>
          </el-row>
          <el-row :gutter="10" class="mb8" >
            <el-col :span="1.5" style="width: 60px">款式：</el-col>
            <el-col :span="20">
              <treeselect :options="styleList" placeholder="款式" v-model="form.styleValues" :normalizer="normalizer" @input="onSpecChange" :multiple="true" />
            </el-col>
          </el-row>

        </el-form-item>
        <!-- <el-divider content-position="center" style="margin-left: 98px;">商品信息</el-divider> -->

        <el-table style="margin-left: 108px;" :data="form.specList" :row-class-name="rowSShopOrderItemIndex" ref="sShopOrderItem">
          <el-table-column label="序号" align="center" prop="index" width="50"/>
          <el-table-column label="颜色" prop="color" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.colorValue" disabled placeholder="颜色" />
            </template>
          </el-table-column>
          <el-table-column label="尺码" prop="size" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.sizeValue" disabled placeholder="尺码" />
            </template>
          </el-table-column>
          <el-table-column label="款式" prop="style" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.styleValue" disabled placeholder="款式" />
            </template>
          </el-table-column>
          <el-table-column label="规格编码" prop="specNum" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.specNum" placeholder="规格编码" />
            </template>
          </el-table-column>
          <el-table-column label="预计采购价" prop="purPrice" width="150">
            <template slot-scope="scope">
              <el-input v-model.number="scope.row.purPrice" placeholder="预计采购价" />
            </template>
          </el-table-column>
<!--          <el-table-column label="规格图片" prop="colorImage" width="150">-->
<!--            <template slot-scope="scope">-->
<!--&lt;!&ndash;              <image-upload v-model="scope.row.colorImage" :limit="1" style="width: 100px;height: 100px"/>&ndash;&gt;-->
<!--              <el-upload-->
<!--                class="avatar-uploader"-->
<!--                :action="uploadImgUrl"-->
<!--                :show-file-list="false"-->
<!--                :headers="headers"-->
<!--                :file-list="fileList"-->
<!--                :on-success="handleUploadSuccess"-->
<!--                :before-upload="handleBeforeUpload">-->
<!--                <img v-if="scope.row.colorImage" :src="scope.row.colorImage" class="avatar">-->
<!--                <i v-else class="el-icon-plus avatar-uploader-icon"></i>-->
<!--              </el-upload>-->
<!--            </template>-->

<!--          </el-table-column>-->
        </el-table>
      </el-form>
      <div slot="footer" class="dialog-footer" style="margin-left: 108px;margin-top:20px;margin-bottom: 50px;">
        <el-button type="primary" @click="submitForm">添加商品</el-button>
        <!-- <el-button @click="cancel">取 消</el-button> -->
      </div>
  </div>
</template>

<script>
import Treeselect from '@riophae/vue-treeselect'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'
import { listCategory } from "@/api/goods/category";
import { listCategoryAttributeValue,listCategoryAttributeValueByCategory } from "@/api/goods/categoryAttributeValue";
import { addGoods } from "@/api/goods/goods";
import { getToken } from "@/utils/auth";
import {
  provinceAndCityData,
  pcTextArr,
  regionData,
  pcaTextArr,
  codeToText,
} from "element-china-area-data";
import {listAllSupplier} from "@/api/scm/supplier";

export default {
  name: "OrderCreate",
  components: { Treeselect },
  data() {
    return {
      uploadImgUrl: process.env.VUE_APP_BASE_API + "/common/upload",
      headers: {
        Authorization: "Bearer " + getToken(),
      },
      // 文件类型, 例如['png', 'jpg', 'jpeg']
      fileType: ["png", "jpg", "jpeg"],
      uploadList: [],
      fileList: [],
      // 表单参数
      form: {
        colorValues:undefined,
        colorImages:{},
        colorNames:{},
        sizeValues:undefined,
        styleValues:undefined,
        number:'',
        specList:[],
        provinces: [],

      },
      supplierList: [],
      pcaTextArr,
      categoryList:[{
          id: '',
          label: '',
          children: [],
      }],
      // 表单校验
      rules: {
        categoryId: [{ required: true, message: '请选择分类' }],
        supplierId: [{ required: true, message: '请选择供应商' }],
        name: [{ required: true, message: '商品名不能为空' }],
        image: [{ required: true, message: '商品图片不能为空' }],
        number: [{ required: true, message: '商品编码不能为空' }],
        purPrice: [{ required: true, message: '请填写预计采购价' }],

      },
      // 子表选中数据
      checkedSShopOrderItem: [],
      // 颜色
      colorList:[],
      // 尺码
      sizeList:[],
      //款式
      styleList:[],
      privateData:{}
    };
  },
  created() {
    this.getCategoryList()
    listAllSupplier({}).then(response => {
      this.supplierList = response.rows;
    });

  },
  methods: {
    categoryChange(val){
      console.log('===========',val)
      if(val.topId === "0"){
        listCategoryAttributeValueByCategory(val.id).then(resp=>{
          this.colorList = resp.data['color']
          this.sizeList = resp.data['size']
          this.styleList = resp.data['styleList']
        })
        // listCategoryAttributeValue(114).then(resp=>{
        //   this.colorList = resp.rows
        // })
        // listCategoryAttributeValue(115).then(resp=>{
        //   this.sizeList = resp.rows
        // })
        // listCategoryAttributeValue(116).then(resp=>{
        //   this.styleList = resp.rows
        // })
      }else{
        listCategoryAttributeValueByCategory(val.topId).then(resp=>{
          // console.log("======333333333344444======",resp)
          this.colorList = resp.data['color']
          this.sizeList = resp.data['size']
          this.styleList = resp.data['styleList']
        })
      }
    },
    // 上传前loading加载
    handleBeforeUpload(file) {
      let isImg = false;
      if (this.fileType.length) {
        let fileExtension = "";
        if (file.name.lastIndexOf(".") > -1) {
          fileExtension = file.name.slice(file.name.lastIndexOf(".") + 1);
        }
        isImg = this.fileType.some(type => {
          if (file.type.indexOf(type) > -1) return true;
          if (fileExtension && fileExtension.indexOf(type) > -1) return true;
          return false;
        });
      } else {
        isImg = file.type.indexOf("image") > -1;
      }

      if (!isImg) {
        this.$modal.msgError(`文件格式不正确, 请上传${this.fileType.join("/")}图片格式文件!`);
        return false;
      }
      if (this.fileSize) {
        const isLt = file.size / 1024 / 1024 < this.fileSize;
        if (!isLt) {
          this.$modal.msgError(`上传头像图片大小不能超过 ${this.fileSize} MB!`);
          return false;
        }
      }
      // this.$modal.loading("正在上传图片，请稍候...");
      // this.number++;
    },
    // 文件个数超出
    handleExceed() {
      this.$modal.msgError(`上传文件数量不能超过 ${this.limit} 个!`);
    },
    // 上传成功回调
    handleUploadSuccess(response, file,ty, color) {
      // console.log('====上传成功回调====',file,response)
      console.log('====上传成功回调====',color,response.url)
      this.$nextTick(()=>{
        this.form.colorImages[color] = response.url
        console.log('=====上传回调赋值=====',this.form.colorImages)
      })
      this.form = { ...this.form, colorImages: { ...this.form.colorImages, [color]: response.url } };
      // if (res.code ===   200) {
      //
      //   this.uploadList.push({ name: res.fileName, url: res.url });
      //   this.uploadedSuccessfully();
      // } else {
      //   this.number--;
      //   this.$modal.closeLoading();
      //   this.$modal.msgError(res.msg);
      //   this.$refs.imageUpload.handleRemove(file);
      //   this.uploadedSuccessfully();
      // }
    },
    // 删除图片
    handleDelete(file) {
      const findex = this.fileList.map(f => f.name).indexOf(file.name);
      if(findex > -1) {
        this.fileList.splice(findex, 1);
        this.$emit("input", this.listToString(this.fileList));
      }
    },
    // 上传失败
    handleUploadError() {
      this.$modal.msgError("上传图片失败，请重试");
      this.$modal.closeLoading();
    },
    // 上传结束处理
    uploadedSuccessfully() {
      if (this.number > 0 && this.uploadList.length === this.number) {
        this.fileList = this.fileList.concat(this.uploadList);
        this.uploadList = [];
        this.number = 0;
        this.$emit("input", this.listToString(this.fileList));
        this.$modal.closeLoading();
      }
    },
    normalizer(node) {
      return {
        id: node.id,
        topId: node.topId,
        label: node.value
      };
    },
    buildTree(list, parentId) {
      let tree = [];
      for (let i = 0; i < list.length; i++) {
        if (list[i].parentId === parentId) {
          let node = {
            id: list[i].id,
            label: list[i].name,
            topId:list[i].topId,
            children: this.buildTree(list, list[i].id)
          };
          tree.push(node);
        }
      }
      return tree;
    },
    /** 查询商品分类列表 */
    getCategoryList() {
      // this.loading = true;
      listCategory(this.queryParams).then(response => {
        this.categoryList = this.buildTree(response.rows,"0")
        // console.log("构建后的list",this.categoryList)
        // this.total = response.total;
        this.loading = false;
      });
    },
    onSpecChange(selected){
      // console.log('=====选择了=======',selected)
      // console.log('=======颜色：====',this.form.colorValues)
      // console.log('=======尺码：====',this.form.sizeValues)
      // console.log('=======款式：====',this.form.styleValues)

      //组合
      if(this.form.colorValues){
        this.form.specList = []
        // this.form.specList.push()
        if(this.form.sizeValues && this.form.styleValues){
          console.log('====颜色、尺码、款式===')
          this.form.colorValues.forEach(c=>{
              const color = this.colorList.find(x=>x.id === c)
              this.form.sizeValues.forEach(s=>{
                const size = this.sizeList.find(y=>y.id === s)
                this.form.styleValues.forEach(st=>{
                const style = this.styleList.find(z=>z.id === st)
                 const spec = {
                  colorId:c,
                  colorValue:color.value,
                  sizeId:s,
                  sizeValue:size.value,
                  styleId:st,
                  styleValue:style.value,
                  specNum:this.form.number+color.skuCode+size.skuCode+style.skuCode
                }
                this.form.specList.push(spec)
                })
              })
            })

        }else {
          // 有一个没有选择
          if(this.form.sizeValues){
            console.log('====颜色、尺码===')
            this.form.colorValues.forEach(c=>{
              const color = this.colorList.find(x=>x.id === c)
              this.form.sizeValues.forEach(s=>{
                const size = this.sizeList.find(y=>y.id === s)
                 const spec = {
                  colorId:c,
                  colorValue:color.value,
                  sizeId:s,
                  sizeValue:size.value,
                  styleId:null,
                  styleValue:'',
                  specNum:this.form.number+color.skuCode+size.skuCode
                }
                this.form.specList.push(spec)
              })
            })
          }else if(this.form.styleValues){
            // 选择了款式
            console.log('====颜色、款式===')

          }else{
            console.log('====颜色===')
            this.form.colorValues.forEach(x=>{
              const color = this.colorList.find(c=>c.id === x)
              const spec = {
                colorId:x,
                colorValue:color.value,
                sizeId:null,
                sizeValue:'',
                styleId:null,
                styleValue:'',
                specNum:this.form.number+color.skuCode
              }
              this.form.specList.push(spec)
            })
          }
        }

        this.form.colorNames = {}
        this.form.colorValues.forEach(c=>{
          const color = this.colorList.find(x=>x.id === c)
          this.form.colorNames[c] = color.value
        })
      }else{
        this.$modal.msgError("必须选择【颜色】")
        this.form.sizeValues = []
        this.form.styleValues = []
      }



    },
    /** ${subTable.functionName}序号 */
    rowSShopOrderItemIndex({ row, rowIndex }) {
      row.index = rowIndex + 1;
    },
    /** 提交按钮 */
    submitForm() {
      console.log('=====添加商品===',this.form)
      this.$refs["form"].validate(valid => {
        if (valid) {

          // 判断规格 specList
          if(!this.form.specList || this.form.specList.length === 0){
            this.$modal.msgError("请添加商品规格")
            return
          }else{
            for(let i=0;i<this.form.specList.length;i++){
              const sp = this.form.specList[i]
              if(!sp.specNum){
                this.$modal.msgError("商品规格编码不能为空")
                return
              }
            }

          }

          addGoods(this.form).then(response => {
              this.$modal.msgSuccess("商品添加成功");
              // 调用全局挂载的方法,关闭当前标签页
              this.$store.dispatch("tagsView/delView", this.$route);
              this.$router.push('/goods/goods_list');
            });
        //   this.form.province = this.form.provinces[0]
        //   this.form.city = this.form.provinces[1]
        //   this.form.town = this.form.provinces[2]

        //   if(this.form.itemList && this.form.itemList.length >0){
        //     this.form.itemList.forEach(x=>{
        //       if(!x.goodsId || !x.quantity){
        //         this.$modal.msgError("请完善商品信息");
        //         return
        //       }
        //     })

        //     console.log('======创建订单=====',this.form)
        //     addOrder(this.form).then(response => {
        //       this.$modal.msgSuccess("订单创建成功");
        //       // 调用全局挂载的方法,关闭当前标签页
        //       this.$store.dispatch("tagsView/delView", this.$route);
        //       this.$router.push('/sale/order/list');
        //     });

        // }else{
        //   this.$modal.msgError("请添加商品");
        // }

        }
      });
    }
  }
};

</script>
<style>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 78px;
  height: 78px;
  line-height: 78px;
  text-align: center;
}
.avatar {
  width: 78px;
  height: 78px;
  display: block;
}
</style>
