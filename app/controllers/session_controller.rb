class SessionController

  def begin
    @controller = SportsController.new()
    apply_user_input
  end

  def apply_user_input
    command = "list"
    while @controller && command != 'end'
      @controller = @controller.navigate_menu(command)
      command = clean_gets.downcase if @controller
    end
  end

end