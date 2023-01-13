require 'db_models'
class FishController < ApplicationController
  layout "bk"
  #layout :set_layout
  #def set_layout
  #  "mddzhusu" if request.host == 'm.ddzhusu.com'
  #end
  @@all_places = Place.select(:en_name, :name).to_a
  def place
    en_name = params[:en_name]
    @place = Place.where(en_name: en_name).take
    if @place.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    redirect_to "http://www.ddzhusu.com/fishnew/#{URI.encode(@place.name)}/", status: 301
  end

  def place_new
    name = params[:name]
    @place = Place.where(name: name).take
    if @place.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    unless is_robot?
      if @place.ptype == 1
        redirect_to "https://www.booking.com/homestay/country/#{@place.en_short}.zh-cn.html?aid=895877"
      elsif @place.ptype == 2
        city = FsCity.where(name: @place.name).take
        redirect_to url_by_city(city)
      elsif @place.ptype == 3
        p2 = Place.where(id: @place.parent_id).take
        city = FsCity.where(name: p2.name).take
        redirect_to url_by_city(city)
      end 
      return
    end
    @places = @@all_places.sample(5)
    if @place.ptype == 3
      @hotels = Hotel.where(fish_tag: @place.fish_tag, status: 1).take(20)
    elsif @place.ptype == 2
      @hotels = Hotel.where(place_id: @place.id,status: 1).take(20)
    elsif @place.ptype == 1
      p2 = Place.where(parent_id: @place.id).select(:id).to_a.sample
      @hotels = Hotel.where(place_id: p2.id, status: 1).take(20)
    else
      @hotels = []
    end
    @rand_hotels = BkCnHotel.where("id > ? and status = 2", rand(1940)).limit(10).select(:url_path_md5, :hotel_name, :address, :images)
  end

  def sitemap
    @places = @@all_places
  end

  def house
    @hotel = Hotel.where(id: params[:hotel_id].to_i).take
    not_found if @hotel.nil?
    unless is_robot?
      city = FsCity.find(@hotel.city_id)
      redirect_to url_by_city(city)
      return
    end
    @comments = JSON.parse(@hotel.comments)
    @recommands = JSON.parse(@hotel.recommands)
    @rooms = JSON.parse(@hotel.rooms)
    @hotels = Hotel.where("id > ? and status = 1", @hotel.id).select(:id,:name).take(5)
    @place_1 = Place.where(id: @hotel.place_id).take
    @place_2 = Place.where(fish_tag: @hotel.fish_tag).to_a
    @rand_hotels = BkCnHotel.where("id > ? and status = 2", rand(1940)).limit(10).select(:url_path_md5, :hotel_name, :address, :images)
  end

  private
  def url_by_city(city)
    if city.booking_city_type == 0
      return "https://www.booking.com/homestay/city/#{city.country_en_short}/#{city.en_short}.zh-cn.html?aid=895877"
    elsif city.booking_city_type == 1
      return "https://www.booking.com/homestay/landmark/#{city.country_en_short}/#{city.en_short}.zh-cn.html?aid=895877"
    elsif city.booking_city_type == 2
      return "https://www.booking.com/homestay/region/#{city.country_en_short}/#{city.en_short}.zh-cn.html?aid=895877"
    else
      return "https://www.booking.com/index.zh-cn.html?aid=895877"
    end
  end
end
