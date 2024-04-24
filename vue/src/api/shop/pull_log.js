import request from '@/utils/request'

export function listShopPullLogs(query) {
  return request({
    url: '/shop/order/pull_logs_list',
    method: 'get',
    params: query
  })
}
