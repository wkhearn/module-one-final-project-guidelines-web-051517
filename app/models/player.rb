class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :draft


  # def initialize(player_name, player_points)
  #   @player_name = player_name
  #   @player_points = player_points
  # end

end
