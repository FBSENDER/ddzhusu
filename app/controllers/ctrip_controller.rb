require 'db_models'
class CtripController < ApplicationController
  layout "bk"
  #layout :set_layout
  #def set_layout
  #  "mddzhusu" if request.host == 'm.ddzhusu.com'
  #end

  @@all_brands = CtBrand.select(:name, :title).to_a

  def brand
    @brand_name = params[:brand_name]
    @brand = CtBrand.where(name: @brand_name).take
    not_found if @brand.nil?
    @brand_detail = CtBrandDetail.where(brand_id: @brand.id).take
    not_found if @brand_detail.nil?
    @cities = JSON.parse(@brand_detail.cities_json)
    @hotels = CtHotel.where(brand_name: @brand.name).to_a.sample(10)
    @brands = @@all_brands.sample(10)
    @rand_hotels = BkCnHotel.where("id > ? and status = 2", rand(1940)).limit(10).select(:url_path_md5, :hotel_name, :address, :images)
  end

  def brand_city
    @brand = CtBrand.where(name: params[:brand_name]).take
    @city_name = params[:city_name]
    not_found if @brand.nil?
    unless is_robot?
      @brand_detail = CtBrandDetail.where(brand_id: @brand.id).take
      not_found if @brand_detail.nil?
      city_pinyin = 'beijing1'
      cities = JSON.parse(@brand_detail.cities_json)
      cities.each do |cc|
        if cc[0] == @city_name
          city_pinyin = cc[1]
          break
        end
      end
      redirect_to "http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=2&Allianceid=297552&sid=762386&OUID=&jumpUrl=http%3A%2F%2Fhotels.ctrip.com%2Fhotel%2F#{city_pinyin}%3Fhid=#{@brand.source_id}%26Allianceid%3D297552%26sid%3D762386%26OUID%3D%26MultiUnionSupport%3Dtrue"
      return
    end
    @hotels = CtHotel.where(brand_name: params[:brand_name], city_name: params[:city_name]).to_a
    not_found if @hotels.size.zero?
    @hotel_details = CtHotelDetail.where(hotel_id: @hotels.map(&:id)).select(:hotel_id,:description,:review).to_a
    @city_names = CtHotel.where("brand_name = ? and city_name <> ?", params[:brand_name], @city_name).pluck(:city_name).uniq
    @brands = @@all_brands.sample(10)
    @rand_hotels = BkCnHotel.where("id > ? and status = 2", rand(1940)).limit(10).select(:url_path_md5, :hotel_name, :address, :images)
  end

  def hotel
    @hotel = CtHotel.where(id: params[:id]).take
    not_found if @hotel.nil?
    unless is_robot?
      redirect_to "http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=2&Allianceid=297552&sid=762386&OUID=&jumpUrl=http%3A%2F%2Fhotels.ctrip.com%2Fhotel%2F#{@hotel.source_id}.html%3FAllianceid%3D297552%26sid%3D762386%26OUID%3D%26MultiUnionSupport%3Dtrue"
      return
    end
    @hotel_detail = CtHotelDetail.where(hotel_id: @hotel.id).take
    not_found if @hotel_detail.nil?
    @description = JSON.parse(@hotel_detail.description)
    @facility = JSON.parse(@hotel_detail.facility)
    @review = JSON.parse(@hotel_detail.review)
    @nearby = JSON.parse(@hotel_detail.nearby)
    @traffic = JSON.parse(@hotel_detail.traffic)
    @hotels = CtHotel.where("id > ?", @hotel.id).select(:id, :title).take(10)
    @rand_hotels = BkCnHotel.where("id > ? and status = 2", rand(1940)).limit(10).select(:url_path_md5, :hotel_name, :address, :images)
  end
end
