class Town < ActiveRecord::Base

  # Primary Key
  self.primary_key = 'grepo_id'

  # Associations
  belongs_to :player, :foreign_key => :player_id
  has_many :conquers, foreign_key: :town_id

  # Link to Island where this town is
  def island_link
    Island.where(island_x: self.island_x, island_y: self.island_y).first
  end


end
