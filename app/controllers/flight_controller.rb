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
    @links = JSON.parse(@line_detail.links_json)
  end
end
