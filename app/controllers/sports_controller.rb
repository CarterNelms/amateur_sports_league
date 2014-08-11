require_relative "base_controller"

class SportsController < BaseController

  MODEL = Sport

  def view(index)
    sport = get_by_index(index.to_i)
    if sport
      
    end
  end

end