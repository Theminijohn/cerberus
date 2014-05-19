desc 'Pull all World Data'
require 'ruby-progressbar'

task :populate_cerberus do

  TASKS =  [ :import_players, :import_alliances, :import_towns,
             :import_conquers, :pkills_all, :pkills_def, :pkills_att, :akills_all,
             :akills_def, :akills_att, :import_islands]

  TASKS.each do |t|
    Rake::Task[t.to_s].invoke
  end

end


