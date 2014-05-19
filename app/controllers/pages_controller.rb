class PagesController < ApplicationController

  def home
    # Find Rank 1 Player
    @first_player = Player.find_by_rank(1)

    # Find Rank 1 Alliance
    @first_alliance = Alliance.find_by_rank(1)
  end

  # Status Page
  def status

  end

end
