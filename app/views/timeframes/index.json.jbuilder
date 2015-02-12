json.array!(@timeframes) do |timeframe|
  json.extract! timeframe, :id, :description
  json.url timeframe_url(timeframe, format: :json)
end
