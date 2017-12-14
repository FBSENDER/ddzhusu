require 'db_models'
class CpsController < ApplicationController
  def ctrip_h5
    user_agent = request.headers["HTTP_USER_AGENT"]
    device = 1
    if user_agent.present? && user_agent =~ /\b(iPhone)\b/i
      device = 2
      redirect_to "http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=2&Allianceid=297552&sid=762386&OUID=&jumpUrl=http%3A%2F%2Fm.ctrip.com%2Fhtml5%2F%3FAllianceid%3D297552%26sid%3D762386%26OUID%3D%26MultiUnionSupport%3Dtrue", status: 302
    else
      redirect_to "https://d.ctrip.com/xz?d=14641", status: 302
    end
    if !is_robot?
      one_click = CpsClick.new
      one_click.ip = request.remote_ip
      one_click.device = device
      one_click.save
    end
  end
end
