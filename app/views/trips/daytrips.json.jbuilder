json.system do
  json.array!(@day_trips) do |trip|
    json.date trip[0].strftime("%Y-%m-%d")
    json.total trip[1].to_s
    json.subscriber @subscriber_trips[trip[0]].to_s
    json.customer @customer_trips[trip[0]].to_s
  end
end
