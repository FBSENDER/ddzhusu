require 'db_models'
class WeatherController < ApplicationController
  layout :set_layout
  def set_layout
    "mddzhusu" if request.host == 'm.ddzhusu.com'
  end

  def show
    poi_id = params[:id]
    pinyin = params[:pinyin]
    @poi = WeatherPoi.where(id: poi_id, pinyin: pinyin).take
    not_found if @poi.nil?
    @detail = WeatherDetail.where(poi_id: @poi.id).take
    not_found if @detail.nil?
    @data = JSON.parse(@detail.detail)
  end

  def today
    poi_id = params[:id]
    pinyin = params[:pinyin]
    @poi = WeatherPoi.where(id: poi_id, pinyin: pinyin).take
    not_found if @poi.nil?
    @detail = WeatherDetail.where(poi_id: @poi.id).take
    not_found if @detail.nil?
    @data = JSON.parse(@detail.detail)
  end

  def tomorrow
    poi_id = params[:id]
    pinyin = params[:pinyin]
    @poi = WeatherPoi.where(id: poi_id, pinyin: pinyin).take
    not_found if @poi.nil?
    @detail = WeatherDetail.where(poi_id: @poi.id).take
    not_found if @detail.nil?
    @data = JSON.parse(@detail.detail)
  end

  def history
    poi_id = params[:id]
    pinyin = params[:pinyin]
    @poi = WeatherPoi.where(id: poi_id, pinyin: pinyin).take
    not_found if @poi.nil?
    @history = WeatherHistory.where(poi_id: @poi.id).order("log_date desc").limit(30).to_a
  end

end


