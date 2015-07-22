require 'csv'

CSV.foreach(filename, :headers => true) do |row|
  Trip.create!(row.to_hash)
end
