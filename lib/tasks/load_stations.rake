desc "load station csv data into db"
namespace :data do
  task :load_stations, [:filename] => [:environment] do |t, args|
    require 'csv'
    Dir.chdir(Rails.root + 'lib/assets/data')
    CSV.foreach(args[:filename], :headers => true) do |row|
      Station.create!(row.to_hash)
    end
  end
end
#http://stackoverflow.com/questions/4410794/ruby-on-rails-import-data-from-a-csv-file
