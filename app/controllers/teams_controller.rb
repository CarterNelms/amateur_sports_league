require_relative "base_controller"

class TeamsController < BaseController

  MODEL = Team

  def initialize(parent=nil)
    @parent = parent
  end

end