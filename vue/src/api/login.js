import request from '@/utils/request'

// 登录方法
export function login(username, password, code, uuid) {
  const data = {
    username,
    password,
    code,
    uuid
  }
  return request({
    url: '/login',
    headers: {
      isToken: false
    },
    method: 'post',
    data: data
  })
}



// 获取用户详细信息
export function getInfo() {
  return request({
    url: '/getInfo',
    method: 'get'
  })
}

// 退出方法
export function logout() {
  return request({
    url: '/logout',
    method: 'post'
  })
}

// 获取验证码
export function getCodeImg() {
  return request({
    url: '/captchaImage',
    headers: {
      isToken: false
    },
    method: 'get',
    timeout: 20000
  })
}


export function signOn(data) {
  return request({
    url: '/signOn',
    method: 'post',
    data:data
  })
}
export function lgFetch(data) {
  return request({
    url: '/api/subscribe/fetch',
    method: 'get',
    params: data
  })
}
export function lgRefresh(data) {
  return request({
    url: '/api/subscribe/refresh',
    method: 'get',
    params: data
  })
}
