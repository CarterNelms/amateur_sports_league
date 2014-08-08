class SessionController

  def begin
    @controller = SportsController.new()
    @controller.list
    apply_user_input
  end

  def apply_user_input
    command = clean_gets.downcase
    @controller = @controller.navigate_menu(command)
    apply_user_input if @controller && command != 'end'
  end



end