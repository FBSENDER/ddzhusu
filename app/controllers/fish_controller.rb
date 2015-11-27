require 'db_models'
class FishController < ApplicationController
  layout :set_layout
  def set_layout
    "mddzhusu" if request.host == 'm.ddzhusu.com'
  end
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
    @places = @@all_places.sample(5)
    if @place.ptype == 3
      @hotels = Hotel.where(fish_tag: @place.fish_tag).take(20)
    elsif @place.ptype == 2
      @hotels = Hotel.where(place_id: @place.id).take(20)
    elsif @place.ptype == 1
      p2 = Place.where(parent_id: @place.id).select(:id).to_a.sample
      @hotels = Hotel.where(place_id: p2.id).take(20)
    else
      @hotels = []
    end
  end

  def sitemap
    @places = @@all_places
  end

  def house
    @hotel = Hotel.where(id: params[:hotel_id].to_i).take
    not_found if @hotel.nil?
    unless is_robot?
      if @hotel.source_id.start_with?('hm')
        redirect_to "http://www.fishtrip.cn/houses/#{@hotel.source_id}?referral_id=1566163562"
        return
      else
        place = Place.find(@hotel.place_id)
        place1 = Place.find(place.parent_id)
        redirect_to "http://www.fishtrip.cn/#{place1.en_name}/#{place.en_name}/?referral_id=1566163562"
        return
      end
    end
    @comments = JSON.parse(@hotel.comments)
    @recommands = JSON.parse(@hotel.recommands)
    @rooms = JSON.parse(@hotel.rooms)
    @hotels = Hotel.where("id > ?", @hotel.id).select(:id,:name).take(5)
    @place_1 = Place.where(id: @hotel.place_id).take
    @place_2 = Place.where(fish_tag: @hotel.fish_tag).to_a
  end
end
