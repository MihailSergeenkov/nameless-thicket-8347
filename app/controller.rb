module DiceRack
  class Controller
    def self.do name
      controller = DiceRack.const_get "#{name.capitalize}Controller"
      controller.new
    end

    def call env
      @request = Rack::Request.new env

      puts @request.params
      if @request.params['action'] == 'login'
        puts @request.params['name']
        @player_name = if @request.params.has_key?('name')
                         @request.params['name'].empty? ?
                             'noname' :
                             @request.params['name']
                       else
                         'noname'
                       end

        @points = Dice::Player::START_POINTS
        @game = Dice.create @player_name
        @game.start_game
        @login = true
        @message = ''
      elsif @request.params['action'] == 'turn'
        if @request.params['bet'].to_i.between?(2,12) and @request.params['stake'].to_i <= @points
          points_after_round = @game.round @request.params['bet'].to_i, @request.params['stake'].to_i
          @message = if points_after_round > @points
                       'Congratulations:)'
                     elsif points_after_round < @points
                       'Loss:('
                     end
          @points = points_after_round
        else
          @message = 'Check your bet or stake (min need points for game - 100)...'
        end
      elsif @request.params['action'] == 'logout'
        @login = false
        @game = nil
      end

      @response = Rack::Response.new
      send_response
    end

    def render name
      template = File.open "public/views/#{name}", File::RDONLY
      ERB.new(template.read).result binding
    end

    private

    def send_response
      @response.write body
      @response.finish
    end

    def headers
      {
          'Content Type' => 'text/html'
      }
    end
  end
end

Dir[DiceRack.root.join('app/controllers/**/*')].each { |controller| require controller }
