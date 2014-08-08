class Router
  def self.navigate_sports_menu(controller, command)
    case command
    when "add"
      controller.add
    when "edit"
      controller.edit
    when "delete"
      controller.delete
    when /\d+/
      controller.view(command.to_i)
      # controller = TeamController.new()
    else
      puts "I don't know the '#{command}' command."
    end
    controller
  end
end
