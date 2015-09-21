class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer   :duration
      t.datetime  :departing_date
      t.string    :departing_station_name
      t.integer   :departing_station_id
      t.datetime  :arriving_date
      t.string    :arriving_station_name
      t.integer   :arriving_station_id
      t.integer   :bike_id
      t.string    :subscriber_type
      t.string    :zip_code

      t.timestamps null: false
    end
  end
end
