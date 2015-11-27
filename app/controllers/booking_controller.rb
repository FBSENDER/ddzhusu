require 'db_models'
class BookingController < ApplicationController
  layout :set_layout
  def set_layout
    "mddzhusu" if request.host == 'm.ddzhusu.com'
  end
  @@all_bk_hotels = BkHotel.select(:id,:name).to_a
  def country
    en_short = params[:en_short]
    @country = BkCountry.where(en_short: en_short).take
    not_found if @country.nil?
    @country_detail = BkCountryDetail.where(country_id: @country.id).select(:cities_json, :hotel_ids).take
    not_found if @country_detail.nil?
    @cities = JSON.parse(@country_detail.cities_json)
    @hotels = BkHotel.where(id: @country_detail.hotel_ids.split(',').map(&:to_i)).select(:id, :name, :price, :score, :description, :en_short).to_a
  end
  def hotel
    @hotel = BkHotel.where(id: params[:hotel_id]).select(:id, :name, :country_en_short, :en_short, :price, :score, :description, :recommand, :facility, :notice, :review).take
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
  end
end
