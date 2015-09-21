class Station < ActiveRecord::Base
  has_many :departing_trips, :foreign_key => "departing_station_id", :class_name => "Trip"
  has_many :arriving_trips, :foreign_key => "arriving_station_id", :class_name => "Trip"

  # scope :in_sf, -> { where(landmark: "San Francisco") }
end
