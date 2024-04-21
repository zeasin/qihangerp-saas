import request from '@/utils/request'

// 查询商品分类属性值列表
export function listCategoryAttributeValue(id) {
  return request({
    url: '/goods/category/attr_value/'+id,
    method: 'get'
  })
}

// 查询商品分类属性值详细
export function getCategoryAttributeValue(id) {
  return request({
    url: '/goods/category/attributeValue/' + id,
    method: 'get'
  })
}

// 新增商品分类属性值
export function addCategoryAttributeValue(data) {
  return request({
    url: '/goods/category/attributeValue',
    method: 'post',
    data: data
  })
}

// 修改商品分类属性值
export function updateCategoryAttributeValue(data) {
  return request({
    url: '/goods/category/attributeValue',
    method: 'put',
    data: data
  })
}

// 删除商品分类属性值
export function delCategoryAttributeValue(id) {
  return request({
    url: '/goods/category/attributeValue/' + id,
    method: 'delete'
  })
}
