require 'db_models'
class BkController < ApplicationController
  layout "bk"
  def city_list
    @hotel_type = params[:hotel_type].nil? ? '酒店' : params[:hotel_type]
    @city_short = params[:city_short]
    @hotels = BkCnHotel.where(city_short: @city_short, hotel_type: @hotel_type, status: [1,2]).select(:id, :url_path_md5, :hotel_name, :country_short, :country_name, :region_short, :region_name, :city_name, :address, :images, :reviews, :status).order("id").limit(20).to_a
    not_found if @hotels.size.zero?
    h = @hotels.first
    @country_short = h.country_short
    @country_name = h.country_name
    @region_short = h.region_short
    @region_name = h.region_name
    @city_name = h.city_name
    unless is_robot?
      redirect_to "https://www.booking.com/city/#{@country_short}/#{@city_short}.zh-cn.html?aid=895877"
      return
    end
    @title = "#{@city_name}#{@hotel_type}_#{@city_name}#{@hotel_type}推荐与预订_滴滴住宿"
    @description = "为您推荐#{@city_name}好评#{@hotel_type}，分别是#{@hotels.map{|h| h.hotel_name}.join('、')}，共#{@hotels.size}家#{@hotel_type}，来滴滴住宿查看更多用户评价信息，欢迎预订！"
    @keywords = "#{@city_name}#{@hotel_type},#{@city_name}#{@hotel_type}预订"
    @lang = "zh-CN"
    @ld_json = {
      "@context"=> "https://schema.org",
      "@type"=> "BreadcrumbList",
      "itemListElement"=> []
    }
    @ld_json["itemListElement"] << {
      "@type"=> "ListItem",
      "position"=> 1,
      "name"=> "滴滴住宿",
      "item"=> "http://www.ddzhusu.com"
    }
    if @hotel_type == '酒店'
      @ld_json["itemListElement"] << {
        "@type"=> "ListItem",
        "position"=> 2,
        "name"=> "#{@city_name}#{@hotel_type}",
        "item"=> "http://www.ddzhusu.com/hotel-city-#{@city_short}"
      }
    else
      @ld_json["itemListElement"] << {
        "@type"=> "ListItem",
        "position"=> 2,
        "name"=> "#{@city_name}#{@hotel_type}",
        "item"=> "http://www.ddzhusu.com/hotel-city-#{@city_short}?hotel_type=#{URI.encode(@hotel_type)}"
      }
    end
  end

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
    @ld_json = {
      "@context"=> "https://schema.org",
      "@type"=> "BreadcrumbList",
      "itemListElement"=> []
    }
    @ld_json["itemListElement"] << {
      "@type"=> "ListItem",
      "position"=> 1,
      "name"=> "滴滴住宿",
      "item"=> "http://www.ddzhusu.com"
    }
    if @hotel_type == '酒店'
      @ld_json["itemListElement"] << {
        "@type"=> "ListItem",
        "position"=> 2,
        "name"=> "#{@hotel.city_name}#{@hotel.hotel_type}",
        "item"=> "http://www.ddzhusu.com/hotel-city-#{@hotel.city_short}"
      }
    else
      @ld_json["itemListElement"] << {
        "@type"=> "ListItem",
        "position"=> 2,
        "name"=> "#{@hotel.city_name}#{@hotel.hotel_type}",
        "item"=> "http://www.ddzhusu.com/hotel-city-#{@hotel.city_short}?hotel_type=#{URI.encode(@hotel.hotel_type)}"
      }
    end
    @ld_json["itemListElement"] << {
      "@type"=> "ListItem",
      "position"=> 3,
      "name"=> "#{@hotel.hotel_name}",
      "item"=> "http://www.ddzhusu.com/hotel-#{@hotel.url_path_md5}"
    }
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
