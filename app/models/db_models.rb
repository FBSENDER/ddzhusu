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
