desc "load trips csv data into db"
namespace :data do
  task :load_trips, [:filename] => [:environment] do |t, args|
    require 'csv'
    Dir.chdir(Rails.root + 'lib/assets/data')
    CSV.foreach(args[:filename], :headers => true) do |row|
      Trip.create!({
        :trip_id          => row[0],
        :duration         => row[1],
        :start_date       => DateTime.strptime(row[2], "%m/%d/%Y %H:%M").strftime("%Y/%m/%d %H:%M"),
        :start_station    => row[3],
        :start_terminal   => row[4],
        :end_date         => DateTime.strptime(row[5], "%m/%d/%Y %H:%M").strftime("%Y/%m/%d %H:%M"),
        :end_station      => row[6],
        :end_terminal     => row[7],
        :bike_id          => row[8],
        :subscriber_type  => row[9],
        :zip_code         => row[10]
      })
    end
  end
end
#http://stackoverflow.com/questions/4410794/ruby-on-rails-import-data-from-a-csv-file
