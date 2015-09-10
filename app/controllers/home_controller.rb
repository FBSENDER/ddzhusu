require 'db_models'
class HomeController < ApplicationController
  def index
    host = request.host
    product = host.split('.').first
    send(product)
  end

  def gaotie
    render :text => 'hello world!'
  end

  def map
    render :text => 'hello world!'
  end

  def www
    @places = Place.all.to_a
    render 'fish/sitemap'
  end

end
