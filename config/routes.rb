Ddzhusu::Application.routes.draw do
  root 'home#index'
  # 旧有路由，常规目录结构
  #root 'fish#sitemap'
  get '/fish/:en_name/', to: 'fish#place'
  get '/fish/', to: 'fish#sitemap'
  get '/train/numbers/', to: 'train#numbers_sitemap'
  get '/train/numbers/:number/', to: 'train#numbers'
  get '/train/timetable/', to: 'train#timetable_sitemap'
  get '/train/timetable/:from_to/', to: 'train#timetable'
  get '/train/timetable/:from_to/gaotie.html', to: 'train#timetable_gaotie'
  get '/train/stations/:station/', to: 'train#stations'
  # 新启用路由规则，测试一级目录的seo优势，放在二级域名下，防止一级域名受牵连
  # 高铁gaotie
  get '/gaotieindex.html', to: 'gaotie#index'
  get '/gt-:from-:to/', to: 'gaotie#shike' 
  get '/gtc-:checi/', to: 'gaotie#checi'
  get '/gts-:station/', to: 'gaotie#station'
  # 动车dongche
  get '/dongcheindex.html', to: 'dongche#index'
  get '/dc-:from-:to/', to: 'dongche#shike'
  get '/dcc-:checi/', to: 'dongche#checi'
  get '/dcs-:station/', to: 'dongche#station'
  # 火车 huoche
  get '/huocheindex.html', to: 'huoche#index'
  get '/hc-:from-:to/', to: 'huoche#shike'
  get '/hcc-:checi/', to: 'huoche#shike'
  get '/hcs-:station/', to: 'huoche#station'
  # 飞机 flight
  get '/flightindex.html', to: 'flight#index'
  get '/fj-:from-:to/', to: 'flight#shike'
  get '/fjs-:station/', to: 'flight#station'
  # 公交 bus
  get '/busindex.html', to: 'bus#index'
  get '/bsc-:city/', to: 'bus#city'
  get '/bsl-:line/', to: 'bus#line' # xx路公交
  get '/bsm-:metro/', to: 'bus#metro' # 地铁
  # 地图 map
  get '/mapindex.html', to: 'map#index'
  get '/mp-:from-:to/', to: 'map#suggest' # 从A到B怎么走
  get '/mpl-:from-:to/', to: 'map#line' # A到B 跨省的长距离路线
  get '/mpp-:poi/', to: 'map#poi' # 到A怎么去
  # 企业 qy
  get '/qyindex.html', to: 'qy#index'
  get '/qy-:name/', to: 'qy#show' #企业信息说明
  # 酒店 hotel
  get '/hotelindex.html', to: 'hotel#index'
  get '/ht-:hotel_id/', to: 'hotel#show' # 单体酒店
  get '/htc-:city/', to: 'hotel#city' # 城市列表页
  get '/htc-:city-:brand/', to: 'hotel#city_brand' # 城市品牌
  get '/htp-:poi/', to: 'hotel#poi' # 城市地标
  get '/htb-:brand/', to: 'hotel#brand' # 差异化的品牌列表页
end
