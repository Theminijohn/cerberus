require 'smarter_csv'
require 'open-uri'
desc "Import Islands from World data"

task :import_islands => [:environment] do

  progress = ProgressBar.create( :format         => '%a %bᗧ%i %p%% %t',
                                 :progress_mark  => ' ',
                                 :remainder_mark => '･',
                                 :total          => nil,
                                 :title          => 'Importing Islands')

  url = "http://#{ENV['WORLD']}.grepolis.com/data/islands.txt"
  url_data = open(url).read()
  File.open('/tmp/islands.txt', 'w') { |file| file.write(url_data) }
  progress.total = open(url).readlines.size

  SmarterCSV.process('/tmp/islands.txt', {
      :user_provided_headers => [
          "grepo_id", "island_x", "island_y", "type_number", "available_towns",
      ], headers_in_file: false
  }) do |array|

    array.each do |a|

      cx = a[:island_x].to_s
      cy = a[:island_y].to_s
      a[:coordinates] = "#{cx}|#{cy}"

      x = a[:island_x].to_s.split('').first
      y = a[:island_y].to_s.split('').first
      a[:ocean] = "#{x}#{y}"

      Island.where(:grepo_id => a[:grepo_id]).first_or_initialize.update_attributes(a)
      progress.increment
    end

  end

end
