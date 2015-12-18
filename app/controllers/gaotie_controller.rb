require 'db_models'
class GaotieController < ApplicationController
  layout :set_layout
  def set_layout
    "mddzhusu" if request.host == 'm.ddzhusu.com'
  end
  def shike
    @line = GaotieLine.where("from_name = ? and to_name = ?", params[:from], params[:to]).take
    not_found if @line.nil?
    #unless is_robot?
    #  if is_device_mobile?
    #    redirect_to "http://m.ctrip.com/html5/trains/#{@line.from_station_pinyin}-#{@line.to_station_pinyin}/?AllianceID=297552&sid=762386&popup=close"      
    #    return
    #  else
    #    redirect_to "http://trains.ctrip.com/TrainBooking/Search.aspx?AllianceID=297552&sid=762386&fromCn=#{URI.encode(params[:from].encode('gb2312'))}&toCn=#{URI.encode(params[:to].encode('gb2312'))}"      
    #    return
    #  end
    #end
    @line_detail = GaotieLineDetail.where(line_id: @line.id).take
    not_found if @line_detail.nil?
    @from_to = "#{@line.from_name}到#{@line.to_name}"
    @gaotie_info = JSON.parse(@line_detail.gaotie_json)
    @gaotie_list = @gaotie_info["train_list"] || []
    @normal_info = JSON.parse(@line_detail.normal_json)
    @normal_list = @normal_info["train_list"] || []
    @date = Date.today + 2
    @stations = JSON.parse(@line_detail.pass_stations)
    @links = JSON.parse(@line_detail.links_json)
  end
  def checi
  end
  def station
  end
end
