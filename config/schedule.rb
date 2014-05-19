# Automated Rake Tasks

every :hour do
  rake "import_players"
  rake "import_alliances"
  rake "import_towns"
end
