class SessionController

  def begin
    controller = SportsController.new()
    command = "list"

    terminate_commands = ['end','exit','quit','q']
    while controller && !terminate_commands.include?(command)
      controller = controller.navigate_menu(command)
      command = clean_gets.downcase if controller
    end
  end

end