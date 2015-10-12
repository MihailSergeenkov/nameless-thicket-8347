require_relative 'lib/dice'
require_relative 'app/dice_rack'

use Rack::Reloader
use Rack::Static, root: 'public', urls: %w(/views /css)

DiceRack::Dispatcher.routes.each_pair do |url, controller|
  map url do
    run DiceRack::Controller.do controller
  end
end