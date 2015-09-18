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

  def card
    @card_name = params[:card_name]
    @card = Card.where("card_name = ?", @card_name).take
    not_found if @card.nil?
    @card_detail  = CardDetail.where(card_id: @card.id).take
    not_found if @card_detail.nil?
    @discount = @card_detail.discount_text
    @handle = @card_detail.handle_text
    @products = JSON.parse(@card_detail.products_json)
  end
end
