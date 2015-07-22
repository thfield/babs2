class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.date      :date
      t.integer   :max_temperature_f
      t.integer   :mean_temperature_f
      t.integer   :min_temperature_f
      t.integer   :max_dewpoint_f
      t.integer   :mean_dewpoint_f
      t.integer   :min_dewpoint_f
      t.integer   :max_humidity
      t.integer   :mean_humidity
      t.integer   :min_humidity
      t.decimal   :max_sea_level_pressure_in
      t.decimal   :mean_sea_level_pressure_in
      t.decimal   :min_sea_level_pressure_in
      t.integer   :max_visibility_miles
      t.integer   :mean_visibility_miles
      t.integer   :min_visibility_miles
      t.integer   :max_wind_speed_mph
      t.integer   :mean_wind_speed_mph
      t.integer   :max_gust_speed_mph
      t.decimal   :precipitation_in
      t.integer   :cloud_cover
      t.string    :events
      t.integer   :wind_dir_degrees
      t.string    :zip_code

      t.timestamps null: false
    end
  end
end
