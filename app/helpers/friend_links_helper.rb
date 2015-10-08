module FriendLinksHelper
  @@redis = Redis.new(host: 'redis_host', port: '6379')
  def get_friend_links
    begin
      result = []
      key = Digest::MD5.hexdigest(request.original_url)
      value = @@redis.get(key)
      result = JSON.parse(value) if value
    rescue Exception => ex
      logger.fatal ex
    ensure
      return result
    end
  end
end
