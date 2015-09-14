require 'db_models'
class BusController < ApplicationController
  def shike
    @line = BusLine.where("from_name = ? and to_name = ?", params[:from], params[:to]).take
    not_found if @line.nil?
    @line_detail = BusLineDetail.where(line_id: @line.id).take
    not_found if @line_detail.nil?
    @from_to = "#{@line.from_name}到#{@line.to_name}"
    @bus_info = JSON.parse(@line_detail.bus_json)
  end
end
