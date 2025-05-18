import request from '@/utils/request'

// 查询出库单列表
export function listStockOutEntry(query) {
  return request({
    url: '/stockOut/list',
    method: 'get',
    params: query
  })
}

// 查询出库单详细
export function getStockOutEntry(id) {
  return request({
    url: '/stockOut/' + id,
    method: 'get'
  })
}

// 出库
export function stockOut(data) {
  return request({
    url: '/stockOut/out',
    method: 'post',
    data: data
  })
}

