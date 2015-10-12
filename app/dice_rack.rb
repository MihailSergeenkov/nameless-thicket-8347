require 'pathname'
require_relative 'dispatcher'

module DiceRack
  def self.root
    Pathname.new File.expand_path('../..', __FILE__)
  end
end
require_relative 'controller'