require 'db_models'
class FlightController < ApplicationController
  layout "bk"
  #layout :set_layout
  #def set_layout
  #  "mddzhusu" if request.host == 'm.ddzhusu.com'
  #end
  def shike
    @lang = "zh-CN"
    @from_name = params[:from]
    @to_name = params[:to]
    @line = FlightLine.where("from_name = ? and to_name = ?", params[:from], params[:to]).take
    not_found if @line.nil?
    @line_detail = FlightLineDetail.where(line_id: @line.id).take
    not_found if @line_detail.nil?
    @from_to = "#{@line.from_name}到#{@line.to_name}"
    @flight_info = JSON.parse(@line_detail.flight_json)
    @info = @flight_info["scheduleVOList"].nil? ? [] : @flight_info["scheduleVOList"]
    @links = JSON.parse(@line_detail.links_json)
    @date = Date.today + 2
    from_city_code = @info.size > 0 ? @info[0]["departCityCode"] : ""
    to_city_code = @info.size > 0 ? @info[0]["arriveCityCode"] : ""
    @ctrip_url = is_device_mobile? ? "https://m.ctrip.com/html5/flight/swift/domestic/#{from_city_code}/#{to_city_code}/#{@date}?AllianceID=297552&sid=762386&ouid=&app=0101X00&" : "https://flights.ctrip.com/itinerary/oneway/#{from_city_code.downcase}-#{to_city_code.downcase}?date=#{@date}&sortByPrice=true&AllianceID=297552&sid=762386&ouid=&app=0101X00&"
    @ld_json = {
      "@context"=> "https://schema.org",
      "@type"=> "BreadcrumbList",
      "itemListElement"=> []
    }
    @ld_json["itemListElement"] << {
      "@type"=> "ListItem",
      "position"=> 1,
      "name"=> "滴滴航班",
      "item"=> "https://flight.ddzhusu.com"
    }
    @ld_json["itemListElement"] << {
      "@type"=> "ListItem",
      "position"=> 2,
      "name"=> "#{@from_to}航班时刻表",
      "item"=> "https://flight.ddzhusu.com/ft-#{URI.encode(@from_name)}-#{URI.encode(@to_name)}/"
    }
  end

  def number
    @lang = "zh-CN"
    @number = FlightNumber.where(name: params[:name]).take
    not_found if @number.nil?
    @flight_info = JSON.parse(@number.flight_json)
    @info = @flight_info["scheduleVOList"].nil? ? [] : @flight_info["scheduleVOList"]
    @links = JSON.parse(@number.links_json)
    @date = Date.today + 2
    from_city_code = @info.size > 0 ? @info[0]["departCityCode"] : ""
    to_city_code = @info.size > 0 ? @info[0]["arriveCityCode"] : ""
    @ctrip_url = is_device_mobile? ? "https://m.ctrip.com/html5/flight/swift/domestic/#{from_city_code}/#{to_city_code}/#{@date}?AllianceID=297552&sid=762386&ouid=&app=0101X00&" : "https://flights.ctrip.com/itinerary/oneway/#{from_city_code.downcase}-#{to_city_code.downcase}?date=#{@date}&sortByPrice=true&AllianceID=297552&sid=762386&ouid=&app=0101X00&"
    @ld_json = {
      "@context"=> "https://schema.org",
      "@type"=> "BreadcrumbList",
      "itemListElement"=> []
    }
    @ld_json["itemListElement"] << {
      "@type"=> "ListItem",
      "position"=> 1,
      "name"=> "滴滴航班",
      "item"=> "https://flight.ddzhusu.com"
    }
    @ld_json["itemListElement"] << {
      "@type"=> "ListItem",
      "position"=> 2,
      "name"=> "航班#{@number.name}时刻表",
      "item"=> "https://flight.ddzhusu.com/ftn-#{@number.name}/"
    }
  end

  def city
    @lang = "zh-CN"
    @city = FlightCity.where(name: params[:city]).take
    not_found if @city.nil?
    @stations = FlightStation.where(city_name: @city.name).select(:name, :lat, :lng)
    @lines = FlightLine.where(from_name: @city.name).select(:from_name, :to_name).to_a
    @ld_json = {
      "@context"=> "https://schema.org",
      "@type"=> "BreadcrumbList",
      "itemListElement"=> []
    }
    @ld_json["itemListElement"] << {
      "@type"=> "ListItem",
      "position"=> 1,
      "name"=> "滴滴航班",
      "item"=> "https://flight.ddzhusu.com"
    }
    @ld_json["itemListElement"] << {
      "@type"=> "ListItem",
      "position"=> 2,
      "name"=> "从#{@city.name}出发的航班",
      "item"=> "https://flight.ddzhusu.com/ftc-#{URI.encode(@city.name)}/"
    }
  end

end
