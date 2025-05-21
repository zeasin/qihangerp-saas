import request from '@/utils/request'


export function getPddOAuthUrl(query) {
  return request({
    url: '/oauth/pdd/getOauthUrl',
    method: 'get',
    params: query
  })
}
export function getPddToken(data) {
  return request({
    url: '/oauth/pdd/getToken',
    method: 'post',
    data: data
  })
}
