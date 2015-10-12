require_relative 'game'
module Dice
  class Player
    START_POINTS = 1000

    def initialize name
      @name = name
      @points = START_POINTS
    end

    def start_game
      @game = Game.new @name, @points
    end

    def round bet, stake
      @game.go bet, stake
    end

    def end_game
      @points = @game.end
    end

    def view_points
      puts "Вы набрали #{@points} очков"
    end
  end
end