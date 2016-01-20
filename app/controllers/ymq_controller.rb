require 'db_models'
class YmqController < ApplicationController
  skip_before_action :set_inside_links
  layout :set_layout
  def set_layout
    "mvxixi" if request.host == 'm.vxixi.com'
  end

  def show
    @video_name = params[:video_name]
    @video = Ymq.where("video_name = ?", @video_name).take
    not_found if @video.nil?
    @video_detail = YmqDetail.where(video_id: @video.id).take
    not_found if @video_detail.nil?
    tags = @video.tags.split(',')
    @title = "#{tags[2]}年#{tags[0]}#{tags[1]}#{tags[3]}_#{tags[4]}_#{tags[5]}"
    @video_info = JSON.parse(@video_detail.video_json)
    @products = JSON.parse(YmqDetail.where(id: 1).take.products_json).sample(8)
    @links = JSON.parse(@video_detail.links_json)
    @related_videos = JSON.parse(@video_detail.related_videos_json)
  end

  def hall_list
    @place_name = params[:place_name]
    @place = BadmintonPlace.where(name: @place_name).take
    not_found if place.nil?
    if @place.ptype == 0
      pc = BadmintonPlace.where(parent_id: @place.id).take
      @halls = BadmintonHall.where(place_id: pc.id).to_a
    elsif @place.ptype == 1
      @halls = BadmintonHall.where(place_id: @place.id).to_a
    end
  end

  def hall_detail
    @hall_name = params[:hall_name]
  end

end
