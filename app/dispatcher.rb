module DiceRack
  class Dispatcher
    def self.routes
      {
          '/'               => :index,
      }
    end
  end
end