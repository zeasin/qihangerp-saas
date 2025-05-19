import request from '@/utils/request'

export function listTask(query) {
  return request({
    url: '/shop/task/list',
    method: 'get',
    params: query
  })
}

export function getTask(taskId) {
  return request({
    url: '/shop/task/' + taskId,
    method: 'get'
  })
}

export function getTaskLogs(taskId) {
  return request({
    url: '/shop/task/logs/' + taskId,
    method: 'get'
  })
}


// 修改
export function updateTask(data) {
  return request({
    url: '/shop/task',
    method: 'put',
    data: data
  })
}

