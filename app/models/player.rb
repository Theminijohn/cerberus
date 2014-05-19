class Player < ActiveRecord::Base

  # Primary Key
  self.primary_key = 'grepo_id'

  # Associations
  has_many :towns
  belongs_to :alliance
  has_many :conquers, foreign_key: :new_player_id


  # Ransack Search Variables
  def self.ransackable_attributes(auth_object = nil)
    ['name', 'points', 'town_count', 'rank', ]
  end

end
