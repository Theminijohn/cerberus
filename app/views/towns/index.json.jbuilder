json.array!(@towns) do |town|
  json.extract! town, :id, :grepo_id, :player_id, :name, :island_x, :island_y, :slot, :points
  json.url town_url(town, format: :json)
end
