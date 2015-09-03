require 'db_models'
class GaotieController < ApplicationController
  def shike
    @from = TrainStation.where(pinyin: params[:from]).take
    @to = TrainStation.where(pinyin: params[:to]).take 
    if @from.nil? || @to.nil?
      not_found
    end
    @numbers = TrainNumber.where("from_to like ?", "% #{@from.id}to#{@to.id} %").take(10)
    if @numbers.size.zero?
      not_found
    end
    @has_gaotie = @numbers.any?{|n| ['D','G','C'].include?n.train_type }
    #@related_urls = @numbers.map{|n| n.from_to.split(',').map{|f| get_timetable_url(f)}}.flatten.sample(20)
    @related_urls = []
  end
  private
  def get_timetable_url(from_to, tag = '火车')
    data = from_to.split('to').map(&:strip)
    from = TrainStation.find(data[0])
    to = TrainStation.find(data[1])
    {"#{from.name}到#{to.name}#{tag}" => "#{from.pinyin}-#{to.pinyin}"}
  end
end
