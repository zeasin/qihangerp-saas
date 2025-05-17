import request from '@/utils/request'

// 查询仓库订单发货列表
export function listShippingStock(query) {
  return request({
    url: '/shipping/stock_shipment_list',
    method: 'get',
    params: query
  })
}
// 查询供应商订单发货列表
export function listShippingSupplier(query) {
  return request({
    url: '/shipping/supplier_shipment_list',
    method: 'get',
    params: query
  })
}


// 查询仓库订单发货详细
export function getShippingDetail(id) {
  return request({
    url: '/shipping/detail/' + id,
    method: 'get'
  })
}

// 供应商代发货-
export function supplierAgentShipment(data) {
  return request({
    url: '/shipping/supplierAgentShipment',
    method: 'post',
    data:data
  })
}
// 自己发货确认出库
export function stockOutConfirm(data) {
  return request({
    url: '/shipping/stock_out_confirm',
    method: 'post',
    data: data
  })
}

