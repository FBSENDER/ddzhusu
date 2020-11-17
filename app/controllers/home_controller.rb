require 'db_models'
class HomeController < ApplicationController
  layout :set_layout_for_diff_hosts

  @@map_lines = MapLine.select(:from_name, :to_name).to_a
  @@map_guides = MapGuide.select(:from_name, :to_name).take(10)
  @@places = Place.all.to_a
  @@bus_lines = BusLine.select(:from_name, :to_name).to_a
  @@hotels = Hoteln.select(:hotel_name).to_a
  @@cards = Card.select(:card_name).to_a
  @@ppq_baikes = PpqBaike.where(status: [0,1]).select(:article_name, :title).to_a
  @@cinemas = Cinema.select(:cinema_name).take(10)

  def index
    host = request.host
    product = host.split('.').first
    send(product)
  end

  def gaotie
    ids = (1..2000).to_a.sample(100)
    @lines = GaotieLine.where(id: ids).select(:from_name, :to_name)
    @trains = TrainNumber.where(id: ids).select(:name)
    render 'gaotie/index'
  end

  def dongche
    ids = (1..2000).to_a.sample(100)
    @lines = GaotieLine.where(id: ids).select(:from_name, :to_name)
    ids1 = (3659..6206).to_a.sample(100)
    @trains = TrainNumber.where(id: ids1).select(:name)
    render 'dongche/index'
  end

  def huoche
    ids = (1..2000).to_a.sample(100)
    @lines = GaotieLine.where(id: ids).select(:from_name, :to_name)
    ids1 = (6207..11236).to_a.sample(100)
    @trains = TrainNumber.where(id: ids1).select(:name)
    render 'huoche/index'
  end

  def map
    @lines = @@map_lines
    @guides = @@map_guides
    @cinemas = @@cinemas
    render 'map/index'
  end

  def bus
    @lines = @@bus_lines
    render 'bus/index'
  end

  def flight
    ids = (1..2000).to_a.sample(100)
    @lines = FlightLine.where(id: ids).select(:from_name, :to_name).to_a
    render 'flight/index'
  end

  def hotel
    @hotels = @@hotels
    @cards = @@cards
    render 'hotel/index'
  end

  def www
    @places = @@places
    @brands = CtBrand.select(:name, :title).order("hotel_count desc").limit(24).to_a
    @themes = CtTheme.select(:name,:title).take(24)
    @clock_cities = ClockCity.select(:name).take(24)
    render 'home/www'
  end

  def ppq
    @ppq_baikes = @@ppq_baikes
    render 'ppq/index'
  end

  def m
    @places = @@places
    @brands = CtBrand.select(:name, :title).order("hotel_count desc").limit(24).to_a
    @themes = CtTheme.select(:name,:title).take(24)
    @clock_cities = ClockCity.select(:name).take(24)
    render 'home/mddzhusu'
  end

  def set_layout_for_diff_hosts
    case request.host
    when "www.ddzhusu.com" then "home"
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
