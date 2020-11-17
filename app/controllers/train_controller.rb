require 'db_models'
class TrainController < ApplicationController
  layout :set_layout
  def set_layout
    "mddzhusu" if request.host == 'm.ddzhusu.com'
  end
  def numbers
    number = params[:number]
    @num = TrainNumber.where(name: number).take
    if @num.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @info = JSON.parse(@num.infos)
    if @info["info"].size.zero? 
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @related = TrainNumber.where("id > ?", @num.id).select(:name).limit(10)
    @related_urls = @num.from_to.split(',').sample(20).map{|f| get_timetable_url(f)}
    @date = Date.today
    @stations = TrainStation.where(name: @info["info"].map{|f| f["stationName"]}).select(:name, :pinyin, :lat, :lng)
    f = @stations.select{|s| s.name == @info["info"][0]["stationName"]}
    @from_station = f.size > 0 ? f.first : @stations[0]
    t = @stations.select{|s| s.name == @info["info"][-1]["stationName"]}
    @to_station = t.size > 0 ? t.first : @stations[-1]
  end

  def numbers_sitemap
    @numbers = TrainNumber.select(:name).to_a
  end

  def timetable
    from_to = params[:from_to]
    ft = from_to.split('-')
    if ft.nil? || ft.size != 2
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @from = TrainStation.where(pinyin: ft[0]).take
    @to = TrainStation.where(pinyin: ft[1]).take 
    @date = Date.today
    if @from.nil? || @to.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    #unless is_robot?
    #  if is_device_mobile?
    #    redirect_to "http://m.ctrip.com/html5/trains/#{ft[0]}-#{ft[1]}/?AllianceID=297552&sid=762386&popup=close"      
    #    return
    #  else
    #    redirect_to "http://trains.ctrip.com/TrainBooking/Search.aspx?AllianceID=297552&sid=762386&fromCn=#{URI.encode(@from.name.encode('gb2312'))}&toCn=#{URI.encode(@to.name.encode('gb2312'))}"      
    #    return
    #  end
    #end
    @numbers = TrainNumber.where("from_to like ?", "% #{@from.id}to#{@to.id} %").take(10)
    if @numbers.size.zero?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @has_gaotie = @numbers.any?{|n| ['D','G','C'].include?n.train_type }
    @related_urls = @numbers.sample(2).map{|n| n.from_to.split(',').sample(10).map{|f| get_timetable_url(f)}}.flatten
  end

  def timetable_gaotie
    from_to = params[:from_to]
    ft = from_to.split('-')
    if ft.nil? || ft.size != 2
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @from = TrainStation.where(pinyin: ft[0]).take
    @to = TrainStation.where(pinyin: ft[1]).take 
    @date = Date.today
    if @from.nil? || @to.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @numbers = TrainNumber.where("from_to like ? and train_type in ('G','D','C')", "% #{@from.id}to#{@to.id} %").take(10)
    if @numbers.size.zero?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @related_urls = @numbers.sample(2).map{|n| n.from_to.split(',').sample(10).map{|f| get_timetable_url(f, '高铁动车组')}}.flatten
  end

  def timetable_sitemap
    page = params[:page] || 0
    page = page.to_i
    numbers = TrainNumber.offset(50 * page).limit(50)
    @next_page = numbers.size == 50? page + 1 : -1
    if numbers.size.zero? 
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @related_urls = numbers.map{|n| n.from_to.split(',').map{|f| get_timetable_url(f)}}.flatten
  end

  def stations
    @station = TrainStation.where(pinyin: params[:station]).take
    if @station.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @date = Date.today
    @froms = TrainNumber.where("from_to like ?", "% #{@station.id}to% ").select(:name)
    @tos = TrainNumber.where("from_to like ?", "%to#{@station.id} %").select(:name)
    n = TrainNumber.where("from_to like ?", "% #{@station.id}to% ").select(:from_to).take
    @related_urls = n.from_to.split(',').sample(20).map{|f| get_timetable_url(f)}
  end

  private
  def get_timetable_url(from_to, tag = '火车')
    data = from_to.split('to').map(&:strip)
    from = TrainStation.find(data[0])
    to = TrainStation.find(data[1])
    {"#{from.name}到#{to.name}#{tag}" => "#{from.pinyin}-#{to.pinyin}"}
  end

end
