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
  end

  def edit
    puts "Which sport do you want to edit? (Number)"
    sport = get_sport_from_user
    if sport
      name = sport.name
      puts "Which attribute of #{name} would you like to change?"
      attribute = clean_gets
      if sport.respond_to?(attribute)
        old_value = sport.send(attribute)
        puts "What is the new value for #{name}'s #{attribute}? (Old value: #{old_value})"
        value = clean_gets
        sport.send("#{attribute}=", value)
        begin
          sport.save!
          puts "#{name}'s #{attribute} has been changed from #{old_value} to #{value}"
        rescue
          sport.send("#{attribute}=", old_value)
          puts "That is not a valid value for #{name}'s #{attribute}"
        end
      else
        puts "That is not a valid attribute"
      end
    end
  end

  def delete
    puts "Which sport do you want to delete? (Number)"
    sport = get_sport_from_user
    if sport
      puts "#{sport.name}: Are your SURE you with to PERMANENTLY DELETE this sport? (y/N)"
      input = clean_gets.downcase
      if input == 'y'
        sport.destroy
        puts "#{sport.name} has been deleted."
      else
        puts "#{sport.name} has NOT been deleted."
      end
    end
  end

  def navigate_menu(command)
    Router.navigate_sports_menu(self, command)
  end

  private

  def get_sport_from_user
    index = clean_gets.to_i
    sport = sports[index-1]
    puts "That is not a valid selection." if sport.nil?
    sport
  end

  def sports
    @sports ||= Sport.all
  end

end