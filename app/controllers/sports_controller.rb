class SportsController

  def add
    puts "What sport do you want to add?"
    name = clean_gets
    sport = Sport.create(name: name)
    if sport.new_record?
      puts sport.errors.full_messages
    else
      puts "#{name} has been added to the list of sports in the league"
    end
  end

  def list
    puts "=============="
    puts "SPORTS"
    puts "=============="
    sports.each_with_index do |sport, index|
      puts "#{index + 1}. #{sport.name}"
    end
    Router.navigate_sports_menu(self)
  end

  private

  def sports
    @sports ||= Sport.all
  end

end