import request from '@/utils/request'

// 查询入库单列表
export function listWmsStockInEntry(query) {
  return request({
    url: '/stockIn/list',
    method: 'get',
    params: query
  })
}

// 查询入库单详细
export function getWmsStockInEntry(id) {
  return request({
    url: '/wms/WmsStockInEntry/' + id,
    method: 'get'
  })
}
// 新增入库单
export function stockInCreate(data) {
  return request({
    url: '/stockIn/create',
    method: 'post',
    data: data
  })
}
// 入库
export function stockIn(data) {
  return request({
    url: '/api/oms-api/stockIn/in',
    method: 'post',
    data: data
  })
}

export function complete(id) {
  return request({
    url: '/wms/WmsStockInEntry/complete/' + id,
    method: 'get'
  })
}

