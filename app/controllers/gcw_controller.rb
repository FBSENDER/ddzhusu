require 'db_models'
class GcwController < ApplicationController

  def show
    @video_name = params[:video_name]
    @video = Gcw.where("video_name = ?", @video_name).take
    not_found if @video.nil?
    @video_detail = GcwDetail.where(video_id: @video.id).take
    not_found if @video_detail.nil?
    @videos = JSON.parse(@video_detail.videos_json)
    @products = JSON.parse(@video_detail.products_json).sample(8)
    @links = JSON.parse(@video_detail.links_json)
  end

end
