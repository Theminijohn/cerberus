require 'smarter_csv'
require 'open-uri'
desc "Import Players"

task :import_players => :environment do

  progress = ProgressBar.create( :format         => '%a %bᗧ%i %p%% %t',
                                 :progress_mark  => ' ',
                                 :remainder_mark => '･',
                                 :total          => nil,
                                 :title          => 'Importing Players')

  url = "http://#{ENV['WORLD']}.grepolis.com/data/players.txt"
  url_data = open(url).read()
  File.open('/tmp/players.txt', 'w') { |file| file.write(url_data) }
  progress.total = open(url).readlines.size

  SmarterCSV.process('/tmp/players.txt', {
    :user_provided_headers => [
      "grepo_id", "name", "alliance_id", "points", "rank", "town_count"
    ], headers_in_file: false
  }) do |array|

    array.each do |a|
      a[:name] = a[:name].to_s
      a[:name] = CGI::unescape(a[:name]).force_encoding('UTF-8')
      Player.where(:grepo_id => a[:grepo_id]).first_or_initialize.update_attributes(a)
      progress.increment
    end

  end

end
