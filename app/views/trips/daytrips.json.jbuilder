json.array!(@day_trips) do |trip|
  json.date trip[0].strftime("%Y-%m-%d")
  json.count trip[1]
end
