require 'smarter_csv'
require 'open-uri'
desc "Import Alliances"

task :import_alliances => [:environment] do

  progress = ProgressBar.create( :format         => '%a %bᗧ%i %p%% %t',
                                 :progress_mark  => ' ',
                                 :remainder_mark => '･',
                                 :total          => nil,
                                 :title          => 'Importing Alliances')

  url = "http://#{ENV['WORLD']}.grepolis.com/data/alliances.txt"
  url_data = open(url).read()
  File.open('/tmp/alliances.txt', 'w') { |file| file.write(url_data) }
  progress.total = open(url).readlines.size

  SmarterCSV.process('/tmp/alliances.txt', {
      :user_provided_headers => [
          "grepo_id", "name", "points", "town_count", "member_count", "rank"
      ], headers_in_file: false
  }) do |array|

    array.each do |a|
      a[:name] = a[:name].to_s
      a[:name] = CGI::unescape(a[:name]).force_encoding('UTF-8')
      Alliance.where(:grepo_id => a[:grepo_id]).first_or_initialize.update_attributes(a)
      progress.increment
    end

  end

end
