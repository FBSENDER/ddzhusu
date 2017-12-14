Ddzhusu::Application.routes.draw do
  root 'home#index'
  # 旧有路由，常规目录结构
  #root 'fish#sitemap'
  #fish
  get '/fish/house/:hotel_id/', to: 'fish#house'
  get '/fish/:en_name/', to: 'fish#place'
  get '/fishnew/:name/', to: 'fish#place_new'
  get '/fish/', to: 'fish#sitemap'
  get '/train/numbers/', to: 'train#numbers_sitemap'
  get '/train/numbers/:number/', to: 'train#numbers'
  get '/train/timetable/', to: 'train#timetable_sitemap'
  get '/train/timetable/:from_to/', to: 'train#timetable'
  get '/train/timetable/:from_to/gaotie.html', to: 'train#timetable_gaotie'
  get '/train/stations/:station/', to: 'train#stations'
  #booking 
  get '/booking/country/:en_short/', to: 'booking#country'
  get '/booking/city/:city_id/', to: 'booking#city'
  get '/booking/hotel/:hotel_id/', to: 'booking#hotel'
  #bookingen
  get '/bookingen/country/:en_short/', to: 'bookingen#country'
  get '/bookingen/city/:city_id/', to: 'bookingen#city'
  get '/bookingen/hotel/:hotel_id/', to: 'bookingen#hotel'
  #ctrip
  get '/ctrip/brand/:brand_name/', to: 'ctrip#brand'
  get '/ctrip/brand/:brand_name/city/:city_name/', to: 'ctrip#brand_city'
  get '/ctrip/hotel/:id/', to: 'ctrip#hotel'
  #clock_hotel
  get '/clockhotel/', to: 'clockhotel#index'
  get '/clockhotel/hotel/:id/', to: 'clockhotel#hotel'
  get '/clockhotel/city/:city_name/', to: 'clockhotel#city'
  get '/clockhotel/brand/:brand_name/', to: 'clockhotel#brand'
  get '/clockhotel/city/:city_name/brand/:brand_name/', to: 'clockhotel#city_brand'
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
  get '/ft-:from-:to/', to: 'flight#shike'
  get '/fts-:station/', to: 'flight#station'
  # 公交 bus
  get '/busindex.html', to: 'bus#index'
  get '/bs-:from-:to/', to: 'bus#shike'
  get '/bsc-:city/', to: 'bus#city'
  get '/bsl-:line/', to: 'bus#line' # xx路公交
  get '/bsm-:metro/', to: 'bus#metro' # 地铁
  # 地图 map
  get '/mapindex.html', to: 'map#index'
  get '/mp-:from-:to/', to: 'map#guide' # 从A到B怎么走
  get '/mpl-:from-:to/', to: 'map#line' # A到B 跨省的长距离路线
  get '/cinema-:cinema_name/', to: 'map#cinema' #poi 电影院
  # 企业 qy
  get '/qyindex.html', to: 'qy#index'
  get '/qy-:name/', to: 'qy#show' #企业信息说明
  # 酒店 hotel
  get '/hotelindex.html', to: 'hotel#index'
  get '/theme-:theme_name/', to: 'hotel#theme'
  get '/ht-:hotel_name/', to: 'hotel#show' # 单体酒店
  get '/htc-:city/', to: 'hotel#city' # 城市列表页
  get '/htc-:city-:brand/', to: 'hotel#city_brand' # 城市品牌
  get '/htp-:poi/', to: 'hotel#poi' # 城市地标
  get '/htb-:brand/', to: 'hotel#brand' # 差异化的品牌列表页
  get '/card-:card_name/', to: 'hotel#card' #品牌酒店会员卡
  # 广场舞 gcw
  get '/vd-:video_name/', to: 'gcw#show' #gcw 视频show
  # 羽毛球ymq
  get '/ymqvd-:video_name/', to: 'ymq#show' #ymq 视频show 
  get '/ymqhalllist-:place_name', to: 'ymq#hall_list' #ymq 场地列表
  get '/ymqhalldetail-:hall_name', to: 'ymq#hall_detail' #ymq 场地详情
  # 乒乓
  get '/ppqbk-:baike_name/', to: 'ppq#baike' #ppq 百科 baike
  get '/ppqvd-:video_name/', to: 'ppq#video' #ppq 视频 video
  # 天气
  get '/weather/', to: 'weather#index' #poi 天气首页
  get '/weather/:pinyin/:id', to: 'weather#show' #poi 天气详情
  get '/weather/today/:pinyin/:id', to: 'weather#today' #poi 今日天气
  get '/weather/tomorrow/:pinyin/:id', to: 'weather#tomorrow' #poi 明日天气
  get '/weather/history/:pinyin/:id', to: 'weather#history' #poi 历史天气
  get '/weather/aqi-today/:pinyin/:id', to: 'weather#aqi_tody' #poi 今日空气质量
  get '/weather/aqi-tomorrow/:pinyin/:id', to: 'weather#aqi_tomorrow' #poi 今日空气质量
  # CPS
  get '/cps/ctrip_h5', to: 'cps#ctrip_h5'
end
