desc "load station csv data into db"
namespace :data do
  task :load_stations, [:filename] => [:environment] do |t, args|
    require 'csv'
    Dir.chdir(Rails.root + 'lib/assets/raw_data')
    CSV.foreach(args[:filename], :headers => true) do |row|
      Station.create!({
        :station_id   => row[0],
        :name         => row[1],
        :lat          => row[2],
        :long         => row[3],
        :dockcount    => row[4],
        :landmark     => row[5],
        :installation => DateTime.strptime(row[6], "%m/%d/%Y").strftime("%Y/%m/%d"),
        :notes        => row[7]
        })
      # puts row.to_hash
    end
  end
end
#http://stackoverflow.com/questions/4410794/ruby-on-rails-import-data-from-a-csv-file
