require 'db_models'
class BookingenController < ApplicationController
  layout :set_layout
  def set_layout
    "mddzhusu" if request.host == 'm.ddzhusu.com'
  end
  @@all_bken_hotels = BkenHotel.select(:id,:title).to_a
  def hotel
    @hotel = BkenHotel.where(hotel_id: params[:hotel_id]).select(:id, :hotel_id, :name,:en_name, :title, :country_en_short, :en_short, :price, :score, :description, :recommand, :facility, :notice, :review).take
    not_found if @hotel.nil?
    unless is_robot?
      redirect_to "http://www.booking.com/hotel/#{@hotel.country_en_short}/#{@hotel.en_short}.html?aid=895877"
      return
    end
    @description = JSON.parse(@hotel.description)
    @recommand = JSON.parse(@hotel.recommand)
    @facility = JSON.parse(@hotel.facility)
    @review = JSON.parse(@hotel.review)
    @hotels = @@all_bken_hotels.sample(10)
    @countries = []
  end
end
