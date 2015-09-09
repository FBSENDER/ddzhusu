require 'db_models'
class TrainController < ApplicationController
  def numbers
    number = params[:number]
    @num = TrainNumber.where(name: number).take
    if @num.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @info = JSON.parse(@num.infos)
    if @info.size.zero? 
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @related = TrainNumber.where(id: (1..8079).to_a.sample(10)).to_a
    @related_urls = @num.from_to.split(',').map{|f| get_timetable_url(f)}
  end

  def numbers_sitemap
    @numbers = TrainNumber.all.to_a
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
    if @from.nil? || @to.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @numbers = TrainNumber.where("from_to like ?", "% #{@from.id}to#{@to.id} %").take(10)
    if @numbers.size.zero?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @has_gaotie = @numbers.any?{|n| ['D','G','C'].include?n.train_type }
    @related_urls = @numbers.map{|n| n.from_to.split(',').map{|f| get_timetable_url(f)}}.flatten.sample(20)
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
    if @from.nil? || @to.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @numbers = TrainNumber.where("from_to like ? and train_type in ('G','D','C')", "% #{@from.id}to#{@to.id} %").take(10)
    if @numbers.size.zero?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @related_urls = @numbers.map{|n| n.from_to.split(',').map{|f| get_timetable_url(f, '高铁动车组')}}.flatten.sample(20)
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
  end

  private
  def get_timetable_url(from_to, tag = '火车')
    data = from_to.split('to').map(&:strip)
    from = TrainStation.find(data[0])
    to = TrainStation.find(data[1])
    {"#{from.name}到#{to.name}#{tag}" => "#{from.pinyin}-#{to.pinyin}"}
  end

end
