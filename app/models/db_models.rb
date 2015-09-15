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
