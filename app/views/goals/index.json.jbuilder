json.array!(@goals) do |goal|
  json.extract! goal, :id, :activity_id, :unit_id, :timeframe_id, :measurement
  json.url goal_url(goal, format: :json)
end
