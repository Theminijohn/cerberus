class Alliance < ActiveRecord::Base

  # Primary Key
  self.primary_key = 'grepo_id'

  # Associations
  has_many :players

end
