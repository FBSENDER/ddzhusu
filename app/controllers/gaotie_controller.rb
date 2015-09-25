require 'db_models'
class GaotieController < ApplicationController
  def shike
    @line = GaotieLine.where("from_name = ? and to_name = ?", params[:from], params[:to]).take
    not_found if @line.nil?
    @line_detail = GaotieLineDetail.where(line_id: @line.id).take
    not_found if @line_detail.nil?
    @from_to = "#{@line.from_name}到#{@line.to_name}"
    @gaotie_info = JSON.parse(@line_detail.gaotie_json)
    @gaotie_list = @gaotie_info["train_list"]
    @normal_info = JSON.parse(@line_detail.normal_json)
    @normal_list = @normal_info["train_list"]
    @date = Date.today + 2
    @stations = JSON.parse(@line_detail.pass_stations)
    @links = JSON.parse(@line_detail.links_json)
  end
  def checi
  end
  def station
  end
end
