require 'db_models'
class BookingController < ApplicationController
  layout :set_layout
  def set_layout
    "mddzhusu" if request.host == 'm.ddzhusu.com'
  end
  @@all_bk_hotels = BkHotel.select(:id,:title).to_a
  def country
    en_short = params[:en_short]
    @country = BkCountry.where(en_short: en_short).take
    not_found if @country.nil?
    @country_detail = BkCountryDetail.where(country_id: @country.id).select(:cities_json, :hotel_ids).take
    not_found if @country_detail.nil?
    @cities = JSON.parse(@country_detail.cities_json)
    @cities_enabled = BkCity.where("status = 1 and country_en_short = ?", @country.en_short).select(:id, :title).to_a.sample(10)
    @hotels = BkHotel.where(id: @country_detail.hotel_ids.split(',').map(&:to_i)).select(:id, :name, :price, :score, :description, :en_short, :title).to_a
    @countries = @@all_bk_countries.sample(10)
  end
  def city
    @city = BkCity.where(id: params[:city_id], status: 1).select(:id, :title, :hotel_count, :country_en_short, :en_short).take
    not_found if @city.nil?
    @detail = BkCityDetail.where(city_id: @city.id).take
    not_found if @detail.nil?
    @hotels = BkHotel.where(id: @detail.hotel_ids.split(',').map(&:to_i)).select(:id, :name, :price, :score, :description, :en_short, :title, :country_en_short).to_a
    @hot_hotels = JSON.parse(@detail.hotels_json)
    @cities = JSON.parse(@detail.cities_json)
    @hot_cities = BkCity.where("status = 1 and country_en_short = ?", @city.country_en_short).select(:id, :title).to_a.sample(10)
    @districts = JSON.parse(@detail.districts_json)
    @landmarks = JSON.parse(@detail.landmarks_json)
    @airports = JSON.parse(@detail.airports_json)
  end
  def hotel
    @hotel = BkHotel.where(id: params[:hotel_id]).select(:id, :name, :title, :country_en_short, :en_short, :price, :score, :description, :recommand, :facility, :notice, :review).take
    not_found if @hotel.nil?
    unless is_robot?
      redirect_to "http://www.booking.com/hotel/#{@hotel.country_en_short}/#{@hotel.en_short}.zh-cn.html?aid=895877"
      return
    end
    @description = JSON.parse(@hotel.description)
    @recommand = JSON.parse(@hotel.recommand)
    @facility = JSON.parse(@hotel.facility)
    @review = JSON.parse(@hotel.review)
    @hotels = @@all_bk_hotels.sample(10)
    @countries = @@all_bk_countries.sample(10)
  end
  @@all_bk_countries = [['gb','英国'],
    ['us','美国'],
    ['jp','日本'],
    ['tw','台湾'],
    ['fr','法国'],
    ['my','马来西亚'],
    ['kr','韩国'],
    ['de','德国'],
    ['ca','加拿大'],
    ['th','泰国'],
    ['au','澳大利亚'],
    ['mv','马尔代夫'],
    ['it','意大利'],
    ['cn','中国'],
    ['nz','新西兰'],
    ['fj','斐济'],
    ['mo','澳门'],
    ['ch','瑞士'],
    ['vn','越南'],
    ['es','西班牙'],
    ['kh','柬埔寨'],
    ['ad','安道尔'],
    ['is','冰岛'],
    ['za','南非'],
    ['pa','巴拿马'],
    ['sc','塞舌尔'],
    ['pt','葡萄牙'],
    ['mu','毛里求斯'],
    ['nl','荷兰'],
    ['mx','墨西哥'],
    ['lk','斯里兰卡'],
    ['om','阿曼'],
    ['tr','土耳其'],
    ['no','挪威'],
    ['se','瑞典'],
    ['mm','缅甸'],
    ['ie','爱尔兰'],
    ['fi','芬兰'],
    ['at','奥地利'],
    ['bs','巴哈马'],
    ['co','哥伦比亚'],
    ['mc','摩纳哥'],
    ['id','印尼'],
    ['gr','希腊'],
    ['hu','匈牙利'],
    ['dk','丹麦'],
    ['la','老挝'],
    ['br','巴西'],
    ['eg','埃及'],
    ['ma','摩洛哥'],
    ['bn','文莱'],
    ['be','比利时'],
    ['ua','乌克兰'],
    ['mt','马耳他'],
    ['in','印度'],
    ['tz','坦桑尼亚'],
    ['ke','肯尼亚'],
    ['cz','捷克'],
    ['aw','阿鲁巴岛'],
    ['ve','委内瑞拉'],
    ['sa','沙特阿拉伯'],
    ['ru','俄罗斯'],
    ['ph','菲律宾'],
    ['pe','秘鲁'],
    ['pk','巴基斯坦'],
    ['jo','约旦'],
    ['jm','牙买加'],
    ['gh','加纳'],
    ['ge','格鲁吉亚'],
    ['cl','智利'],
    ['bz','伯利兹'],
    ['ar','阿根廷'],
    ['xc','克里米亚'],
    ['cw','库拉索岛'],
    ['ae','阿拉伯联合酋长国'],
    ['si','斯洛文尼亚'],
    ['rw','卢旺达'],
    ['pl','波兰'],
    ['ni','尼加拉瓜'],
    ['mg','马达加斯加'],
    ['lu','卢森堡'],
    ['li','列支敦士登'],
    ['il','以色列'],
    ['iq','伊拉克'],
    ['hn','洪都拉斯'],
    ['et','埃塞俄比亚'],
    ['cr','哥斯达黎加'],
    ['cv','佛得角'],
    ['bo','玻利维亚'],
    ['bb','巴巴多斯岛']]
end
