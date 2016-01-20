class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_inside_links

  def not_found
    raise ActionController::RoutingError.new('您访问的页面不存在')
  end

  def is_device_mobile?
    user_agent = request.headers["HTTP_USER_AGENT"]
    user_agent.present? && user_agent =~ /\b(Android|iPhone|iPad|Windows Phone|Opera Mobi|Kindle|BackBerry|PlayBook|UCWEB|Mobile)\b/i
  end

  def is_robot?
    user_agent = request.headers["HTTP_USER_AGENT"]
    user_agent.present? && user_agent =~ /(bot|spider|slurp)/i
  end

  def set_inside_links
    begin
      @inside_links = []
      url_md5 = Digest::MD5.hexdigest(request.original_url)
      current_url = InsideLink.where(url_md5: url_md5).select(:order_index).take
      return if current_url.nil? 
      @inside_links = InsideLink.where("order_index > ?", current_url.order_index).order("order_index").select(:url, :anchor).take(20)
    rescue Exception => ex
      logger.fatal ex
    end
  end

end
