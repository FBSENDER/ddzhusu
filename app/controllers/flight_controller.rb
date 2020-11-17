require 'db_models'
class FlightController < ApplicationController
  layout :set_layout
  def set_layout
    "mddzhusu" if request.host == 'm.ddzhusu.com'
  end
  def shike
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
  end
end
