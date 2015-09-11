require 'db_models'
class HomeController < ApplicationController
  layout :set_layout_for_diff_hosts
  def index
    host = request.host
    product = host.split('.').first
    send(product)
  end

  def gaotie
    @lines = GaotieLine.select(:from_name, :to_name).to_a
    render 'gaotie/index'
  end

  def dongche
    @lines = GaotieLine.select(:from_name, :to_name).to_a
    render 'dongche/index'
  end

  def map
    @lines = MapLine.select(:from_name, :to_name).to_a
    @guides = MapGuide.select(:from_name, :to_name).take(10)
    render 'map/index'
  end

  def www
    @places = Place.all.to_a
    render 'fish/sitemap'
  end

  private
  def set_layout_for_diff_hosts
    case request.host
    when "gaotie.ddzhusu.com" then "gaotie"
    when "map.ddzhusu.com" then "map"
    when "dongche.ddzhusu.com" then "dongche"
    else "application"
    end
  end

end
