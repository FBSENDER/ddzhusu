require 'db_models'
class HotelController < ApplicationController
  layout :set_layout
  def set_layout
    "mddzhusu" if request.host == 'm.ddzhusu.com'
  end
  @@themes = CtTheme.select(:name,:title).to_a
  def show
    @hotel_name = params[:hotel_name]
    @hotel = Hoteln.where("hotel_name = ?", @hotel_name).take
    not_found if @hotel.nil?
    @hotel_detail = HotelnDetail.where(hotel_id: @hotel.id).take
    not_found if @hotel_detail.nil?
    @desc = JSON.parse(@hotel_detail.desc_json)
    @comments = JSON.parse(@hotel_detail.comment_json)
    @links = JSON.parse(@hotel_detail.links_json)
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
    @links = JSON.parse(@card_detail.links_json)
  end

  def theme
    @theme_name = params[:theme_name]
    @theme = CtTheme.where(name: @theme_name).take
    not_found if @theme.nil?
    ids = @theme.hotel_ids.split(',')
    ids = ids + (1..2000).to_a.sample(20-ids.size) 
    @hotels = Hoteln.where(id: ids).select(:hotel_name,:id,:elong_id,:img_url).to_a
    @hotel_details = HotelnDetail.where(hotel_id: ids).select(:hotel_id,:desc_json).to_a
    @themes = @@themes.sample(5)
  end
end
