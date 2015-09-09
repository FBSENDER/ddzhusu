class Place < ActiveRecord::Base
  self.table_name = 'fstnotes_base_fish_places'
end

class Hotel < ActiveRecord::Base
  self.table_name = 'fstnotes_base_fish_hotels'
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
class TrainStation < ActiveRecord::Base

  self.table_name = 'huoche_stations'
  
  attr_accessor :detail
  
  def self.get_without_detail(name)
    TrainStation.where(name: name).take
  end

  def self.get(name)
    station = TrainStation.where(pingyin: name).take
    station.detail = TrainStationDetail.select(:related_desc, :train_numbers, :related_train_numbers).where(station_id: station.id).take if station
    station
  end

  def train_numbers_info
    if self.detail
      JSON.parse(self.detail.train_numbers)
    else
      []
    end
  end

  def related_train_numbers_info
    if self.detail
      JSON.parse(self.detail.related_train_numbers)
    else
      []
    end
  end

end
class TrainStationDetail < ActiveRecord::Base
  self.table_name = 'huoche_station_details'
end
