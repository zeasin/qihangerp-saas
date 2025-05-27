import request from '@/utils/request'

// 查询退换货列表
export function listReturned(query) {
  return request({
    url: '/afterSale/returned_list',
    method: 'get',
    params: query
  })
}

// 查询退换货详细
export function getReturned(id) {
  return request({
    url: '/afterSale/detail/' + id,
    method: 'get'
  })
}

// 新增退换货
export function updateUserWaybill(data) {
  return request({
    url: '/afterSale/returned/updateUserWaybill',
    method: 'post',
    data: data
  })
}

