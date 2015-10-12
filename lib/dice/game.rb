require_relative 'validator'
module Dice
  class Game
    include Validator

    def initialize name, points
      @name = name
      @points = points
      puts "#{@name}, игра началась!!!"
    end

    def go bet, stake
      if can_play? :start_game
        if not stake
          puts 'Введите ставку'
          @bet = gets.to_i
        else
          @bet = stake
        end

        if can_play? :player_bet
          if not bet
            puts 'Введите число'
            @number = gets.to_i
          else
            @number = bet
          end

          if can_play? :player_number
            #puts win?(@number) ?
            #         "Вы угадали, у Вас #{@points += @bet} очков!" :
            #         "Вы не угадали, у Вас #{@points -= @bet} очков!"
            win?(@number) ? @points += @bet : @points -= @bet
          else
            puts error
          end
        else
          puts error
        end
      else
        puts error
      end
    end

    def end
      puts "#{@name}, игра закончена!!!"
      @points
    end

    private

    def win? number
      number == rand
    end

    def rand
      Kernel.rand DICE_RANGE
    end
  end
end