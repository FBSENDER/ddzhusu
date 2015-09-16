require 'db_models'
class HotelController < ApplicationController
  def show
    @hotel_name = params[:hotel_name]
    @hotel = Hoteln.where("hotel_name = ?", @hotel_name).take
    not_found if @hotel.nil?
    @hotel_detail = HotelnDetail.where(hotel_id: @hotel.id).take
    not_found if @hotel_detail.nil?
    @desc = JSON.parse(@hotel_detail.desc_json)
    @comments = JSON.parse(@hotel_detail.comment_json)
  end
end
