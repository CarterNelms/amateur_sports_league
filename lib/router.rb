class Router
  def self.navigate_sports_menu(controller)
    command = clean_gets
    case command
    when "add"
      controller.add
    when /\d+/
      controller.view(command.to_i)
    else
      puts "I don't know the '#{command}' command."
    end
  end
end
