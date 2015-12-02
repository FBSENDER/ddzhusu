module ApplicationHelper
  def title(page_title = "滴滴住宿")
      content_for :title, page_title.to_s
  end
  def keywords(page_keywords = "滴滴住宿")
    content_for :keywords, page_keywords.to_s
  end
  def head_desc(page_descriptions = "")
    content_for :head_desc, page_descriptions.to_s
  end
  def mobile_url(domain, path)
    content_for :mobile_url, "http://#{domain}#{path}/"
  end
  def page_lang(lang = 'zh-CN')
    content_for :page_lang, lang
  end
  def get_train_type(word)
    case word
    when 'D' then '动车'
    when 'G' then '高铁'
    when 'C' then '城际'
    when 'T' then '特快'
    when 'Z' then '直达'
    when 'L' then '临客'
    when 'K' then '普快'
    else '普快'
    end
  end
  def distance_desc(distance)
    if distance < 1000
      "#{distance}米"
    elsif distance >= 1000 && distance < 5000
      "#{distance * 1.0 / 1000}公里"
    else
      "大约#{(distance * 1.0 / 1000).ceil}公里"
    end
  end

  def duration_desc(duration)
    if duration < 3600
      "大约#{duration / 60}分钟"
    elsif duration % 3600 <= 600
      "大约#{duration / 3600}小时"
    else
      "大约#{duration / 3600}小时#{(duration / 60) - ((duration / 3600) * 60)}分钟"
    end
  end
  def route_desc(from, to)
    templates = [
      "$1到$2怎么走？","$1到$2怎么走最快？","$1到$2怎么走最方便？",
      "$1到$2的乘车方案？","$1到$2多少公里？","$1到$2得公交车有哪些？",
      "$1到$2怎么直达？"
    ]
    templates.sample.sub('$1',from).sub('$2',to)
  end
end
