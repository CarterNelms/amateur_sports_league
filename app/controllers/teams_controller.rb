require_relative "base_controller"

class TeamsController < BaseController

  MODEL = Team

  def initialize(sport)
    @parent = sport
  end

end