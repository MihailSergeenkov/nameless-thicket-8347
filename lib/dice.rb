require_relative 'dice/player'
module Dice
  def self.create name
    Player.new name
  end

  def self.version
    '1.0.0'
  end
end


#player_1 = Dice.create 'Vasya'
#player_1.start_game
#player_1.round
#player_1.round
#player_1.end_game
#player_1.view_points