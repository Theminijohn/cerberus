## Information

### Cerberus is a [Grepolis](http://www.grepolis.com) Analytics Tool

I'm pulling every hour the latest Data from the Grepolis "[API](http://wiki.de.grepolis.com/wiki/Weltdaten)". You cann see all the Tasks under the 'lib/task' Directory

```ruby

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


```

The API consists of 

```ruby
:players, :towns, :islands, :conquers, :player_kills, :alliance_kills
```

With this Data i show the changes happening in the Game, and provide a Directory for Analytics.

## Project Info

I started this Project ± 2 Weeks ago, so everyting you see here is in a very messy state. You can see what gems and plugins i use in the gem file.

Right now i'm working on the UI and '[Versioning](https://github.com/airblade/paper_trail)' so i can track and display changes over time.
