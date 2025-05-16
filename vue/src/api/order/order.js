import request from '@/utils/request'

// 查询订单列表
export function listOrder(query) {
  return request({
    url: '/order/list',
    method: 'get',
    params: query
  })
}

// 查询订单详细
export function getOrder(id) {
  return request({
    url: '/order/' + id,
    method: 'get'
  })
}

// 手动发货
export function manualShipmentOrder(data) {
  return request({
    url: '/order/manualShipment',
    method: 'post',
    data: data
  })
}

// 分配供应商发货
export function allocateShipmentOrder(data) {
  return request({
    url: '/order/allocateShipmentOrder',
    method: 'post',
    data: data
  })
}
