class SessionController

  TERMINATE_COMMANDS = ['end','exit','quit','q']

  def begin
    @controller = SportsController.new()
    @command = "list"
    sign_in
    apply_user_input
  end

  def sign_in
    puts "Hello. Please enter your username"
    username = clean_gets.capitalize
    # Player.create(username: username, first_name: 'Carter', last_name: "Nelms", age: 24, is_male: true)
    @user = Player.where("username = '#{username}'").first
    if @user
      puts "Welcome #{@user.username}"
    else
      puts "Hello #{username}. Would you like to create a new account? (y/N)"
      input = clean_gets.downcase
      if input == 'y' || input == 'yes'
        @user = PlayersController.new().add(username)
        @command = "exit" unless @user
      else      
        puts "Now exiting..."
        @command = "exit"
      end
    end
  end

  def apply_user_input
    while @controller && !TERMINATE_COMMANDS.include?(@command)
      possible_new_controller = Router.navigate_session(@command)
      if possible_new_controller
        @controller = possible_new_controller
      else
        @controller = @controller.navigate_menu(@command, @user) # unless Router.navigate_session(self, @command)
      end
      @command = clean_gets.downcase if @controller
    end
  end

end