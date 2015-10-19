require 'db_models'
class PpqController < ApplicationController

  def baike
    @baike_name = params[:baike_name]
    @baike = PpqBaike.where("baike_name = ?", @baike_name).take
    not_found if @baike.nil?
    @baike_detail = PpqBaikeDetail.where(baike_id: @baike.id).take
    not_found if @baike_detail.nil?
    @contents = JSON.parse(@baike_detail.contents_json)
    @products = JSON.parse(PpqBaikeDetail.where(id: 1).take.products_json).sample(8)
    @links = JSON.parse(@baike_detail.links_json)
  end

  def video
    @video_name = params[:video_name]
    @video = PpqVideo.where("video_name = ?", @video_name).take
    not_found if @video.nil?
    @video_detail = PpqVideoDetail.where(video_id: @video.id).take
    not_found if @video_detail.nil?
    tags = @video.tags.split(',')
    @title = "#{tags[2]}年#{tags[0]}#{tags[1]}#{tags[3]}_#{tags[4]}_#{tags[5]}"
    @video_info = JSON.parse(@video_detail.video_json)
    @products = JSON.parse(PpqVideoDetail.where(id: 1).take.products_json).sample(8)
    @links = JSON.parse(@video_detail.links_json)
    @related_videos = JSON.parse(@video_detail.related_videos_json)
  end

end
