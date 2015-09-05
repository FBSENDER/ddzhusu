require 'db_models'
class GaotieController < ApplicationController
  def shike
    @from = TrainStation.where(pinyin: params[:from]).take
    @to = TrainStation.where(pinyin: params[:to]).take 
    if @from.nil? || @to.nil?
      not_found
    end
    @numbers = TrainNumber.where("from_to like ? ", "% #{@from.id}to#{@to.id} %").take(20)
    if @numbers.size.zero?
      not_found
    end
  end
  def checi
  end
  def station
  end
end
