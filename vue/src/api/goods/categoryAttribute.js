import request from '@/utils/request'

// 查询商品分类属性列表
export function listCategoryAttribute(id) {
  return request({
    url: '/goods/category/attributeList/'+id,
    method: 'get'
  })
}

// 查询商品分类属性详细
export function getCategoryAttribute(id) {
  return request({
    url: '/goods/category/attribute/' + id,
    method: 'get'
  })
}

// 新增商品分类属性
export function addCategoryAttribute(data) {
  return request({
    url: '/goods/category/attribute',
    method: 'post',
    data: data
  })
}

// 修改商品分类属性
export function updateCategoryAttribute(data) {
  return request({
    url: '/goods/category/attribute',
    method: 'put',
    data: data
  })
}

// 删除商品分类属性
export function delCategoryAttribute(id) {
  return request({
    url: '/goods/category/attribute/' + id,
    method: 'delete'
  })
}
