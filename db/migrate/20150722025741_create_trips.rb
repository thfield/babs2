class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :trip_id
      t.integer :duration
      t.datetime :start_date
      t.string :start_station
      t.integer :start_terminal
      t.datetime :end_date
      t.string :end_station
      t.integer :end_terminal
      t.integer :bike_id
      t.string :subscriber_type
      t.string :zip_code

      t.timestamps null: false
    end
  end
end
