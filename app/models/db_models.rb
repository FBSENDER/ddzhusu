class Place < ActiveRecord::Base
  self.table_name = 'fstnotes_base_fish_places'
end

class Hotel < ActiveRecord::Base
  self.table_name = 'fstnotes_base_fish_hotels'
end
class FsCountry < ActiveRecord::Base
  self.table_name = 'fstnotes_base_fish_countries'
end
class FsCity < ActiveRecord::Base
  self.table_name = 'fstnotes_base_fish_cities'
end

class BkCountry < ActiveRecord::Base
  self.table_name = 'booking_countries'
end
class BkCountryDetail < ActiveRecord::Base
  self.table_name = 'booking_country_details'
end
class BkCity < ActiveRecord::Base
  self.table_name = 'booking_cities'
end
class BkCityDetail < ActiveRecord::Base
  self.table_name = 'booking_city_details'
end
class BkHotel < ActiveRecord::Base
  self.table_name = 'booking_hotels'
end
class BkenHotel < ActiveRecord::Base
  self.table_name = 'booking_en_hotels'
end
class CtBrand < ActiveRecord::Base
  self.table_name = 'ctrip_brands'
end
class CtTheme < ActiveRecord::Base
  self.table_name = 'ctrip_hotel_themes'
end
class CtBrandDetail < ActiveRecord::Base
  self.table_name = 'ctrip_brand_details'
end
class CtHotel < ActiveRecord::Base
  self.table_name = 'ctrip_hotels'
end
class CtHotelDetail < ActiveRecord::Base
  self.table_name = 'ctrip_hotel_details'
end

class TrainNumber < ActiveRecord::Base
  self.table_name = 'fstnotes_base_train_numbers'
end

class TrainStation < ActiveRecord::Base
  self.table_name = 'fstnotes_base_train_stations'
end

class GaotieLine < ActiveRecord::Base
  self.table_name = 'huoche_gaotie_lines'
end
class GaotieLineDetail < ActiveRecord::Base
  self.table_name = 'huoche_gaotie_line_details'
end

class MapLine < ActiveRecord::Base
  self.table_name = 'huoche_map_lines'
end
class MapLineDetail < ActiveRecord::Base
  self.table_name = 'huoche_map_line_details'
end

class MapGuide < ActiveRecord::Base
  self.table_name = 'huoche_map_guides'
end
class MapGuideDetail < ActiveRecord::Base
  self.table_name = 'huoche_map_guide_details'
end

class BusLine < ActiveRecord::Base
  self.table_name = 'huoche_bus_lines'
end
class BusLineDetail < ActiveRecord::Base
  self.table_name = 'huoche_bus_line_details'
end

class FlightLine < ActiveRecord::Base
  self.table_name = 'huoche_flight_lines'
end
class FlightLineDetail < ActiveRecord::Base
  self.table_name = 'huoche_flight_line_details'
end

class Hoteln < ActiveRecord::Base
  self.table_name = 'huoche_hotels'
end
class HotelnDetail < ActiveRecord::Base
  self.table_name = 'huoche_hotel_details'
end

class Card < ActiveRecord::Base
  self.table_name = 'huoche_hotel_cards'
end
class CardDetail < ActiveRecord::Base
  self.table_name = 'huoche_hotel_card_details'
end

class Gcw < ActiveRecord::Base
  self.table_name = 'gcw_videos'
end
class GcwDetail < ActiveRecord::Base
  self.table_name = 'gcw_video_details'
end

class Ymq < ActiveRecord::Base
  self.table_name = 'ymq_videos'
end
class YmqDetail < ActiveRecord::Base
  self.table_name = 'ymq_video_details'
end

class PpqBaike < ActiveRecord::Base
  self.table_name = 'ppq_baikes'
end
class PpqBaikeDetail < ActiveRecord::Base
  self.table_name = 'ppq_baike_details'
end

class PpqVideos < ActiveRecord::Base
  self.table_name = 'ppq_videos'
end
class PpqVideoDetails < ActiveRecord::Base
  self.table_name = 'ppq_video_details'
end

class Cinema < ActiveRecord::Base
  self.table_name = 'huoche_map_poi_cinemas'
end
class CinemaDetail < ActiveRecord::Base
  self.table_name = 'huoche_map_poi_cinema_details'
end

class BadmintonDistrict < ActiveRecord::Base
  self.table_name = 'ymq_places'
end
class BadmintonHall < ActiveRecord::Base
  self.table_name = 'ymq_place_details'
end

class ClockHotel < ActiveRecord::Base
  self.table_name = 'clock_hotels'
end
class ClockHotelDetail < ActiveRecord::Base
  self.table_name = 'clock_hotel_details'
end
class ClockCity < ActiveRecord::Base
  self.table_name = 'clock_cities'
end
class ClockBrand < ActiveRecord::Base
  self.table_name = 'clock_brands'
end

class InsideLink < ActiveRecord::Base
  self.table_name = 'inside_links'
end

class WeatherPoi < ActiveRecord::Base
  self.table_name = 'weather_pois'
end

class WeatherHistory < ActiveRecord::Base
  self.table_name = 'weather_history'
end

class WeatherDetail < ActiveRecord::Base
  self.table_name = 'weather_details'
end
