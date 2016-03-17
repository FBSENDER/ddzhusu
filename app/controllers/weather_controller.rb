require 'db_models'
class WeatherController < ApplicationController
  layout :set_layout
  def set_layout
    "mddzhusu" if request.host == 'm.ddzhusu.com'
  end

  def index
    @pois = WeatherPoi.where("level = 2").to_a
  end

  def show
    poi_id = params[:id]
    pinyin = params[:pinyin]
    @poi = WeatherPoi.where(id: poi_id, pinyin: pinyin).take
    not_found if @poi.nil?
    not_found if @poi.level == 1
    @detail = WeatherDetail.where(poi_id: @poi.id).take
    if @detail.nil?
      @poi_parent = WeatherPoi.where(id: @poi.parent_id).take
      not_found if @poi_parent.nil?
      not_found if @poi_parent.level == 1
      @detail = WeatherDetail.where(poi_id: @poi_parent.id).take
      if @detail.nil?
        @poi_parent_p = WeatherPoi.where(id: @poi_parent.parent_id).take
        not_found if @poi_parent_p.nil?
        not_found if @poi_parent_p.level == 1
        @detail = WeatherDetail.where(poi_id: @poi_parent_p.id).take
      end
    end
    not_found if @detail.nil?
    @data = JSON.parse(@detail.detail)
    @related_pois = []
    if @poi.level == 2
      @related_pois += WeatherPoi.where("id > ? and level = 2 ", @poi.id).take(5)
      @related_pois += WeatherPoi.where(parent_id: @poi.id).to_a
    elsif @poi.level == 3
      @related_pois += WeatherPoi.where(id: @poi.parent_id).to_a
      @related_pois += WeatherPoi.where("id > ? and level = 3", @poi.id).take(5)
      @related_pois += WeatherPoi.where(parent_id: @poi.id).to_a
    elsif @poi.level == 4
      @related_pois += WeatherPoi.where(id: @poi.parent_id).to_a
      @related_pois += WeatherPoi.where("id > ? and level = 3", @poi.id).take(5)
    end
  end

  def today
    show
  end

  def tomorrow
    show
  end

  def history
    poi_id = params[:id]
    pinyin = params[:pinyin]
    @poi = WeatherPoi.where(id: poi_id, pinyin: pinyin).take
    not_found if @poi.nil?
    not_found if @poi.level == 1
    if @poi.level == 4
      @poi = WeatherPoi.where(id: @poi.parent_id).take
      not_found if @poi.nil?
    end
    @history = WeatherHistory.where(poi_id: @poi.id).order("log_date desc").limit(30).to_a
    @related_pois = []
    if @poi.level == 2
      @related_pois += WeatherPoi.where("id > ? and level = 2 ", @poi.id).take(5)
      @related_pois += WeatherPoi.where(parent_id: @poi.id).to_a
    elsif @poi.level == 3
      @related_pois += WeatherPoi.where(id: @poi.parent_id).to_a
      @related_pois += WeatherPoi.where("id > ? and level = 3", @poi.id).take(5)
      @related_pois += WeatherPoi.where(parent_id: @poi.id).to_a
    elsif @poi.level == 4
      @related_pois += WeatherPoi.where(id: @poi.parent_id).to_a
      @related_pois += WeatherPoi.where("id > ? and level = 3", @poi.id).take(5)
    end
  end

end


