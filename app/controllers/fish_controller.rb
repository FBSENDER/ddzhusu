require 'db_models'
class FishController < ApplicationController
  @@all_places = Place.select(:en_name, :name).to_a
  def place
    en_name = params[:en_name]
    @place = Place.where(en_name: en_name).take
    if @place.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @places = @@all_places.sample(5)
    if @place.ptype == 3
      @hotels = Hotel.where(place_id: @place.id).take(20)
    elsif @place.ptype == 2
      place_ids = Place.where(parent_id: @place.id).to_a.map(&:id)
      @hotels = Hotel.where(place_id: place_ids).take(20)
    elsif @place.ptype == 1
      p2 = Place.where(parent_id: @place.id).to_a.sample
      place_ids = Place.where(parent_id: p2.id).to_a.map(&:id)
      @hotels = Hotel.where(place_id: place_ids).take(20)
    else
      @hotels = []
    end
  end

  def sitemap
    @places = @@all_places
  end
end
