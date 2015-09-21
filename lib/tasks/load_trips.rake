desc "load trips csv data into db"
namespace :data do
  task :load_trips, [:filename] => [:environment] do |t, args|
    require 'csv'
    Dir.chdir(Rails.root + 'lib/assets/raw_data')
    CSV.foreach(args[:filename], :headers => true) do |row|
      Trip.create!({
        :id               => row[0],
        :duration         => row[1],
        :departing_date       => DateTime.strptime(row[2], "%m/%d/%Y %H:%M").strftime("%Y/%m/%d %H:%M"),
        :departing_station_name    => row[3],
        :departing_station_id   => row[4],
        :arriving_date         => DateTime.strptime(row[5], "%m/%d/%Y %H:%M").strftime("%Y/%m/%d %H:%M"),
        :arriving_station_name      => row[6],
        :arriving_station_id     => row[7],
        :bike_id          => row[8],
        :subscriber_type  => row[9],
        :zip_code         => row[10]
      })
    end
  end
end
#http://stackoverflow.com/questions/4410794/ruby-on-rails-import-data-from-a-csv-file
#command: rake data:load_trips[some_trips.csv]
