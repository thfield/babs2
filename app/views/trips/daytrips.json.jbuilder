json.array!(@day_trips) do |trip|
  json.date trip[0].strftime("%Y-%m-%d")
  json.rides trip[1].to_s
end
