require 'db_models'
class HomeController < ApplicationController
  layout :set_layout_for_diff_hosts

  @@train_lines = GaotieLine.select(:from_name, :to_name).to_a
  @@map_lines = MapLine.select(:from_name, :to_name).to_a
  @@map_guides = MapGuide.select(:from_name, :to_name).take(10)
  @@places = Place.all.to_a
  @@bus_lines = BusLine.select(:from_name, :to_name).to_a
  @@flight_lines = FlightLine.select(:from_name, :to_name).to_a
  @@hotels = Hoteln.select(:hotel_name).to_a
  @@cards = Card.select(:card_name).to_a
  @@ppq_baikes = PpqBaike.where(status: [0,1]).select(:article_name, :title).to_a

  def index
    host = request.host
    product = host.split('.').first
    send(product)
  end

  def gaotie
    @lines = @@train_lines
    render 'gaotie/index'
  end

  def dongche
    @lines = @@train_lines
    render 'dongche/index'
  end

  def huoche
    @lines = @@train_lines
    render 'huoche/index'
  end

  def map
    @lines = @@map_lines
    @guides = @@map_guides
    render 'map/index'
  end

  def bus
    @lines = @@bus_lines
    render 'bus/index'
  end

  def flight
    @lines = @@flight_lines
    render 'flight/index'
  end

  def hotel
    @hotels = @@hotels
    @cards = @@cards
    render 'hotel/index'
  end

  def www
    @places = @@places
    render 'fish/sitemap'
  end

  def ppq
    @ppq_baikes = @@ppq_baikes
    render 'ppq/index'
  end

  def set_layout_for_diff_hosts
    case request.host
    when "gaotie.ddzhusu.com" then "gaotie"
    when "map.ddzhusu.com" then "map"
    when "dongche.ddzhusu.com" then "dongche"
    when "huoche.ddzhusu.com" then "huoche"
    when "bus.ddzhusu.com" then "bus"
    when "flight.ddzhusu.com" then "flight"
    when "hotel.ddzhusu.com" then "hotel"
    when "www.1024yy.wang" then "movie"
    when "www.2026cup.com" then "soccer"
    when "ppq.vxixi.com" then "ppq"
    else "application"
    end
  end

end
