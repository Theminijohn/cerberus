json.array!(@islands) do |island|
  json.extract! island, :id, :grepo_id, :island_x, :island_y, :type_number, :available_towns
  json.url island_url(island, format: :json)
end
