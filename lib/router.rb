class Router
  def self.navigate_sports_menu(controller, command)
    case command
    when "add", "edit", "delete", "list"
      controller.send(command)
    when /\d+/
      sport = controller.get_by_index(command.to_i)
      controller = TeamsController.new(sport)
      controller.list
    else
      puts "I don't know the '#{command}' command."
    end
    controller
  end

  def self.navigate_teams_menu(controller, command)
    case command
    when "add", "edit", "delete", "list"
      controller.send(command)
    when /\d+/
      sport = controller.get_by_index(command.to_i)
      # controller = PlayersController.new(sport)
      controller.list
    else
      puts "I don't know the '#{command}' command."
    end
    controller
  end
end
