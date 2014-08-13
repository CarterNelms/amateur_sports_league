require_relative "base_controller"

class TeamsController < BaseController

  MODEL = Team

  def initialize(sport=nil)
    @parent = sport
  end

end