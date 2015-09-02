Ddzhusu::Application.routes.draw do
  # 旧有路由，常规目录结构
  root 'fish#sitemap'
  get '/fish/:en_name/', to: 'fish#place'
  get '/fish/', to: 'fish#sitemap'
  get '/train/numbers/', to: 'train#numbers_sitemap'
  get '/train/numbers/:number/', to: 'train#numbers'
  get '/train/timetable/', to: 'train#timetable_sitemap'
  get '/train/timetable/:from_to/', to: 'train#timetable'
  get '/train/timetable/:from_to/gaotie.html', to: 'train#timetable_gaotie'
  # 新启用路由规则，测试一级目录的seo优势，放在二级域名下，防止一级域名受牵连
  # 高铁
  get '/gt-:from-:to/', to: 'gaotie#shike'
  # 动车
  get '/dc-:from-:to/', to: 'dongche#shike'
  # 火车时刻
  get '/hc-:from-:to/', to: 'huoche#shike'
end
