require 'db_models'
class MapController < ApplicationController
  layout :set_layout
  def set_layout
    "mddzhusu" if request.host == 'm.ddzhusu.com'
  end
  def guide
    @from_name = params[:from]
    @to_name = params[:to]
    @from_to = "#{@from_name}到#{@to_name}"
    @guide = MapGuide.where(from_name: @from_name, to_name: @to_name).take
    not_found if @guide.nil?
    @guide_detail = MapGuideDetail.where(guide_id: @guide.id).take
    @bus_info = JSON.parse(@guide_detail.by_bus)
    @car_info = JSON.parse(@guide_detail.by_car)
    @foot_info = JSON.parse(@guide_detail.on_foot)
    @from_lines = MapGuide.where(from_name: @from_name).select(:from_name,:to_name).to_a.sample(10)
    @to_lines = MapGuide.where(to_name: @to_name).select(:from_name,:to_name).to_a.sample(10)
    @links = JSON.parse(@guide_detail.links_json)
    not_found if @guide_detail.nil?
  end

  def line
    @from_name = params[:from]
    @to_name = params[:to]
    @from_to = "#{@from_name}到#{@to_name}"
    @line = MapLine.where(from_name: @from_name, to_name: @to_name).take
    not_found if @line.nil?
    @line_detail = MapLineDetail.where(line_id: @line.id).take
    not_found if @line_detail.nil?
    @flight = JSON.parse(@line_detail.by_air)
    @train = JSON.parse(@line_detail.by_train)
    @bus = JSON.parse(@line_detail.by_bus)
    @car_route = JSON.parse(@line_detail.by_car)
    @desc = page_desc(@from_to, @flight, @train, @bus, @car_route)
    @links = JSON.parse(@line_detail.links_json)
  end

  def cinema
    @cinema_name = params[:cinema_name]
    @cinema = Cinema.where(cinema_name: @cinema_name).take
    not_found if @cinema.nil?
    @cinema_detail = CinemaDetail.where(cinema_id: @cinema.id).take
    not_found if @cinema_detail.nil?
    @info = JSON.parse(@cinema_detail.cinema_json)
    @meituan_products = JSON.parse(@cinema_detail.meituan_json)
    @related_cinemas = JSON.parse(@cinema_detail.related_cinemas_json)
    @links = JSON.parse(@cinema_detail.links_json)
  end

  def badmintonhall
  end

  private 
  def page_desc(from_to, flight, train, bus, car)
    if flight.size.zero? && train.size.zero? && bus.size.zero? && car.size.zero?
      return "滴滴地图查询到#{from_to}的出行信息，#{from_to}火车票、机票、汽车票、自驾路线等信息尚在完善中，敬请关注。"
    end
    desc = "滴滴地图为您提供#{from_to}出行选择，"
    if train.size > 0
      desc += "您可以乘坐火车，共查询到#{train.size}次#{from_to}的火车，推荐乘坐高铁/动车组列车，舒适便捷速度快，列车车次有#{train.take(15).map{|t| t["trainNumber"]}.join('，')}。"
    end
    if flight.size > 0 
      desc += "您可以选择乘飞机从#{from_to}，有#{flight.size}次航班，本站提供#{from_to}机票查询、航线航班信息查询，特价机票请见本站其他频道。"
    end
    if bus.size > 0
      desc += "#{from_to}长途汽车时刻表，每日有#{bus.size}班汽车。"
    end
    if car.size > 0
      desc += "选择自驾，#{from_to}驾车距离#{(car["distance"].to_i / 1000).ceil}公里，预计耗时#{(car["duration"].to_i / 3600).ceil}小时，详细的路线信息由百度地图提供。"
    end
    desc += "希望本站的信息有助于您顺利出行。"
  end
end
