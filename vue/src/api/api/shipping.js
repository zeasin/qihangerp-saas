import request from '@/utils/request'

// 查询
export function listShipping(query) {
  return request({
    url: '/shipping/list',
    method: 'get',
    params: query
  })
}


// 新增
export function handShip(data) {
  return request({
    url: '/api/oms-api/shipping/handShip',
    method: 'post',
    data: data
  })
}

