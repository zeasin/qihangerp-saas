import request from '@/utils/request'

// 查询物流公司列表
export function listLogistics(query) {
  return request({
    url: '/shipping/logistics/list',
    method: 'get',
    params: query
  })
}

// 查询物流公司详细
export function getLogistics(id) {
  return request({
    url: '/shipping/logistics/' + id,
    method: 'get'
  })
}

// 新增物流公司
export function addLogistics(data) {
  return request({
    url: '/shipping/logistics/add',
    method: 'post',
    data: data
  })
}

// 修改物流公司
export function updateLogistics(data) {
  return request({
    url: '/shipping/logistics/edit',
    method: 'put',
    data: data
  })
}

// 删除物流公司
export function delLogistics(id) {
  return request({
    url: '/shipping/logistics/del/' + id,
    method: 'delete'
  })
}

export function listLogisticsStatus(query) {
  return request({
    url: '/shipping/logistics/status_list',
    method: 'get',
    params: query
  })
}
// 修改物流状态
export function updateStatus(data) {
  return request({
    url: '/shipping/logistics/updateStatus',
    method: 'put',
    data: data
  })
}
//接口拉取快递公司
export function pullLogisticsCompanyList(platformId) {
  return request({
    url: '/logistics/pull_logistics_company?platformId='+platformId,
    method: 'post'
  })
}
