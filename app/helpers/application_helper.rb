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
end
