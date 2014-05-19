class Conquer < ActiveRecord::Base

  # Primary Key
  self.primary_key = 'town_id'
  belongs_to :town
  belongs_to :player, foreign_key: :new_player_id


  # Old owner of Town
  def old_player
    Player.find_by_grepo_id(self.old_player_id)
  end

  # Old Alliance of Owner
  def old_alliance
    Alliance.find_by_grepo_id(self.old_ally_id)
  end

  # Time of Conquer
  def conquer_time
    Time.at(self.time).strftime("%d-%m-%Y")
  end

  # Town Name
  def town
    Town.find(self.town_id)
  end

  # Interne Eroberung?
  def intern_conquer?
    oa = Alliance.find_by_grepo_id(self.old_ally_id)
    na = Alliance.find_by_grepo_id(self.new_ally_id)

    if oa == na
      true
    else
      false
    end
  end


end
