import request from '@/utils/request'

// 查询列表
export function listGoods(query) {
  return request({
    url: '/api/open-api/pdd/goods/list',
    method: 'get',
    params: query
  })
}

// 查询sku列表
export function listGoodsSku(query) {
  return request({
    url: '/api/open-api/pdd/goods/skuList',
    method: 'get',
    params: query
  })
}


export function getGoodsSku(id) {
  return request({
    url: '/api/open-api/pdd/goods/sku/'+id,
    method: 'get',
  })
}


export function linkErpGoodsSkuId(data) {
  return request({
    url: '/api/open-api/pdd/goods/sku/linkErp',
    method: 'post',
    data: data
  })
}

// 接口拉取商品
export function pullGoodsList(data) {
  return request({
    url: '/api/open-api/pdd/goods/pull_goods',
    method: 'post',
    data: data
  })
}
//推送商品到商品库
export function pushToOms(data) {
  return request({
    url: '/api/open-api/pdd/goods/push_oms',
    method: 'post',
    data: data
  })
}
