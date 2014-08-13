require_relative "base_controller"

class PlayersController < BaseController

  MODEL = Player

  def initialize(parent=nil)
    @parent = parent
  end

end