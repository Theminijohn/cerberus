require 'smarter_csv'
require 'open-uri'
desc "Import Conquers from World data"

task :import_conquers => [:environment] do

  progress = ProgressBar.create( :format         => '%a %bᗧ%i %p%% %t',
                                 :progress_mark  => ' ',
                                 :remainder_mark => '･',
                                 :total          => nil,
                                 :title          => 'Importing Conquers')

  url = "http://#{ENV['WORLD']}.grepolis.com/data/conquers.txt"
  url_data = open(url).read()
  File.open('/tmp/conquers.txt', 'w') { |file| file.write(url_data) }
  progress.total = open(url).readlines.size

  SmarterCSV.process('/tmp/conquers.txt', {
      :user_provided_headers => [
          "town_id", "time", "new_player_id", "old_player_id", "new_ally_id", "old_ally_id", "town_points"
      ], headers_in_file: false
  }) do |array|

    array.each do |a|
      Conquer.where(:town_id => a[:town_id]).first_or_initialize.update_attributes(a)
      progress.increment
    end

  end

end
