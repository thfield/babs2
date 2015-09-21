class Trip < ActiveRecord::Base
  belongs_to :departing_station, :class_name => "Station"
  belongs_to :arriving_station, :class_name => "Station"
end
