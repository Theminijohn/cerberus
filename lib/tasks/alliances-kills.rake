require 'smarter_csv'
require 'open-uri'
desc "Import Alliances Bash Points"


task :akills_all => [:environment] do

  url = "http://#{ENV['WORLD']}.grepolis.com/data/alliance_kills_all.txt"
  url_data = open(url).read()
  File.open('/tmp/ak_all.txt', 'w') { |file| file.write(url_data) }

  SmarterCSV.process('/tmp/ak_all.txt', {
      :user_provided_headers => [
          "all_rank", "grepo_id", "all_points"
      ], headers_in_file: false
  }) do |array|

    array.each do |a|
      Alliance.where(:grepo_id => a[:grepo_id]).update_all(:all_rank => a[:all_rank], :all_points => a[:all_points])
    end

  end

end



task :akills_def => [:environment] do

  url = "http://#{ENV['WORLD']}.grepolis.com/data/alliance_kills_def.txt"
  url_data = open(url).read()
  File.open('/tmp/ak_def.txt', 'w') { |file| file.write(url_data) }

  SmarterCSV.process('/tmp/ak_def.txt', {
      :user_provided_headers => [
          "def_rank", "grepo_id", "def_points"
      ], headers_in_file: false
  }) do |array|

    array.each do |a|
      Alliance.where(:grepo_id => a[:grepo_id]).update_all(:def_rank => a[:def_rank], :def_points => a[:def_points])
    end

  end

end



task :akills_att => [:environment] do

  url = "http://#{ENV['WORLD']}.grepolis.com/data/alliance_kills_att.txt"
  url_data = open(url).read()
  File.open('/tmp/ak_att.txt', 'w') { |file| file.write(url_data) }

  SmarterCSV.process('/tmp/ak_att.txt', {
      :user_provided_headers => [
          "att_rank", "grepo_id", "att_points"
      ], headers_in_file: false
  }) do |array|

    array.each do |a|
      Alliance.where(:grepo_id => a[:grepo_id]).update_all(:att_rank => a[:att_rank], :att_points => a[:att_points])
    end

  end

end
