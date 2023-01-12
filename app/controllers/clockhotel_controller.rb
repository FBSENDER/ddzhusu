require 'db_models'
class ClockhotelController < ApplicationController
  layout "bk"
  #layout :set_layout
  #def set_layout
  #  "mddzhusu" if request.host == 'm.ddzhusu.com'
  #end
  
  def index
    @city_names = ClockCity.all.pluck(:name)
    @brand_names = ClockBrand.all.pluck(:name)
    @hotels = ClockHotel.where(id: (1..1000).to_a.sample(18)).select(:id,:name,:shop_time,:price,:room_hour).to_a
    @rand_hotels = BkCnHotel.where("id > ? and status = 2", rand(1940)).limit(10).select(:url_path_md5, :hotel_name, :address, :images)
  end

  def hotel
    @hotel_id = params[:id].to_i
    @hotel = ClockHotel.where(id: @hotel_id).take
    not_found if @hotel.nil?
    @hotel_detail = ClockHotelDetail.where(hotel_id: @hotel.id).take
    not_found if @hotel_detail.nil?
    @hotel_name = @hotel.name
    @rooms = JSON.parse(@hotel_detail.room_json)
    @desc = JSON.parse(@hotel_detail.desc_json)
    @comments = JSON.parse(@hotel_detail.comment_json)
    @same_city_hotels = ClockHotel.where(city_name: @hotel.city_name).select(:id,:img_url,:name,:room_hour).take(4) unless @hotel.city_name.empty?
    @same_chain_hotels = ClockHotel.where(chain_name: @hotel.chain_name).select(:id,:img_url,:name,:room_hour).take(4) unless @hotel.chain_name.empty?
    @related_hotels = ClockHotel.where("id > ?",@hotel.id).select(:id,:name,:img_url,:room_hour).take(6)
    @links = JSON.parse(@hotel_detail.links_json)
    @rand_hotels = BkCnHotel.where("id > ? and status = 2", rand(1940)).limit(10).select(:url_path_md5, :hotel_name, :address, :images)
  end

  def city
    @city_name = params[:city_name]
    @city = ClockCity.where(name: @city_name).take
    not_found if @city.nil?
    @chain_hotels = []
    JSON.parse(@city.chain_hotels).each do |ch|
      ch["hotels"] = ClockHotel.where(id: ch["hotel_ids"].split(',').sample(6)).select(:id,:name,:shop_time,:price,:room_hour).to_a
      @chain_hotels << ch
    end
    @hotels = ClockHotel.where(id: @city.hotel_ids.split(',').sample(18)).select(:id,:name,:shop_time,:price,:room_hour).to_a
    @links = JSON.parse(@city.links_json)
    @rand_hotels = BkCnHotel.where("id > ? and status = 2", rand(1940)).limit(10).select(:url_path_md5, :hotel_name, :address, :images)
  end

  def brand
    @brand_name = params[:brand_name]
    @brand = ClockBrand.where(name: @brand_name).take
    not_found if @brand.nil?
    @city_hotels = []
    JSON.parse(@brand.city_hotels).sample(5).each do |ch|
      ch["hotels"] = ClockHotel.where(id: ch["hotel_ids"].split(',').sample(6)).select(:id,:name,:shop_time,:price,:room_hour).to_a
      @city_hotels << ch
    end
    @hotels = ClockHotel.where(id: @brand.hotel_ids.split(',').sample(18)).select(:id,:name,:shop_time,:price,:room_hour).to_a
    @links = JSON.parse(@brand.links_json)
    @rand_hotels = BkCnHotel.where("id > ? and status = 2", rand(1940)).limit(10).select(:url_path_md5, :hotel_name, :address, :images)
  end

  def city_brand
    @city_name = params[:city_name]
    @brand_name = params[:brand_name]
    @hotels = ClockHotel.where(city_name: @city_name, chain_name: @brand_name).select(:id,:name,:shop_time,:price,:room_hour).to_a.sample(20)
    not_found if @hotels.size.zero?
    @rand_hotels = BkCnHotel.where("id > ? and status = 2", rand(1940)).limit(10).select(:url_path_md5, :hotel_name, :address, :images)
  end
end
