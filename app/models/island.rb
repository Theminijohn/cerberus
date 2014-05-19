class Island < ActiveRecord::Base

  # Primary Key
  self.primary_key = 'grepo_id'

  # Island Towns
  def towns
    Town.where(:island_x => self.island_x, :island_y => self.island_y)
  end

end
