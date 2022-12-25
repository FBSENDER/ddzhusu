require 'db_models'
class BkController < ApplicationController
  layout "bk"
  def hotel_detail
    @hotel = BkCnHotel.where(url_path_md5: params[:url_md5].to_s, status: 2).take
    not_found if @hotel.nil?
    unless is_robot?
      redirect_to "http://www.booking.com#{@hotel.url_path}?aid=895877"
      return
    end
    @title = "#{@hotel.title}_#{@hotel.hotel_type}预订_滴滴住宿"
    @description = "#{@hotel.title}：#{@hotel.hotel_desc}"
    @keywords = "#{@hotel.hotel_name},#{@hotel.hotel_type}预订,#{@hotel.country_name}#{@hotel.hotel_type}预订,#{@hotel.region_name}#{@hotel.hotel_type}预订,#{@hotel.city_name}#{@hotel.hotel_type}预订"
    @lang = "zh-CN"
    @hotels = BkCnHotel.where(city_short: @hotel.city_short, hotel_type: @hotel.hotel_type).where("id > ? and status = 2", @hotel.id).select(:id, :url_path_md5, :hotel_name).order(:id).limit(10)
    @has_de = BkDeHotel.where(url_path_md5: params[:url_md5].to_s, status: 2).select(:id).take
  end

  def hotel_de_detail
    @hotel = BkDeHotel.where(url_path_md5: params[:url_md5].to_s, status: 2).take
    not_found if @hotel.nil?
    unless is_robot?
      cn_url = "http://www.booking.com#{@hotel.url_path}?aid=895877"
      redirect_to cn_url.sub("zh-cn", "de")
      return
    end
    @title = "#{@hotel.title}, #{@hotel.city_name} - Aktualisierte Preise für 2022"
    @description = "#{@hotel.title}：#{@hotel.hotel_desc}"
    @keywords = "#{@hotel.hotel_name},#{@hotel.hotel_type}"
    @lang = "de"
    @hotels = BkDeHotel.where(city_short: @hotel.city_short, hotel_type: @hotel.hotel_type).where("id > ? and status = 2", @hotel.id).select(:id, :url_path_md5, :hotel_name).order(:id).limit(10)
    @has_cn = BkCnHotel.where(url_path_md5: params[:url_md5].to_s, status: 2).select(:id).take
  end
end
