json.array!(@conquers) do |conquer|
  json.extract! conquer, :id, :town_id, :time, :new_player_id, :old_player_id, :new_ally_id, :old_ally_id, :town_points
  json.url conquer_url(conquer, format: :json)
end
