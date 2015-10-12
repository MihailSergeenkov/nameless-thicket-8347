module Dice
  module Validator
    MIN_START_POINTS = 99
    DICE_RANGE = 2..12

    attr_reader :error

    def can_play? check
      clear_error!
      self.send "check_#{check}!"
      @error.nil? ? true : false
    end

    private

    def clear_error!
      @error = nil
    end

    def check_start_game!
      @error = "У Вас #{@points} очков, а минимальный порог #{MIN_START_POINTS} очков, Вы не можете играть у нас" unless @points > MIN_START_POINTS
    end

    def check_player_bet!
      @error = "Вы сделали ставку #{@bet}, а у Вас #{@points} очков, игра не возможна" if @bet > @points
    end

    def check_player_number!
      @error = "Вы выбрали число #{@number}, игра не возможна, т.к. нужно выбрать в диапозоне от #{DICE_RANGE.min} до #{DICE_RANGE.max}" unless DICE_RANGE.include? @number
    end
  end
end