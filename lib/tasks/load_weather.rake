desc "load weather csv data into db"
namespace :data do
  task :load_weather, [:filename] => [:environment] do |t, args|
    require 'csv'
    Dir.chdir(Rails.root + 'lib/assets/data')
    CSV.foreach(args[:filename], :headers => true) do |row|
      Weather.create!({
        :date                       => DateTime.strptime(row[0], "%m/%d/%Y").strftime("%Y/%m/%d"),
        :max_temperature_f          => row[1],
        :mean_temperature_f         => row[2],
        :min_temperature_f          => row[3],
        :max_dewpoint_f             => row[4],
        :mean_dewpoint_f            => row[5],
        :min_dewpoint_f             => row[6],
        :max_humidity               => row[7],
        :mean_humidity              => row[8],
        :min_humidity               => row[9],
        :max_sea_level_pressure_in  => row[10],
        :mean_sea_level_pressure_in => row[11],
        :min_sea_level_pressure_in  => row[12],
        :max_visibility_miles       => row[13],
        :mean_visibility_miles      => row[14],
        :min_visibility_miles       => row[15],
        :max_wind_speed_mph         => row[16],
        :mean_wind_speed_mph        => row[17],
        :max_gust_speed_mph         => row[18],
        :precipitation_in           => row[19],
        :cloud_cover                => row[20],
        :events                     => row[21],
        :wind_dir_degrees           => row[22],
        :zip_code                   => row[23]
      })
    end
  end
end
#http://stackoverflow.com/questions/4410794/ruby-on-rails-import-data-from-a-csv-file
