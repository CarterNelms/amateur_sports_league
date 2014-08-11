class BaseController

  def navigate_menu(command)
    Router.send("navigate_#{type_name_plural}_menu", *[self, command])
  end

  private

  def model 
    self.class::MODEL
  end

  def type_name
    (begin self.class::TYPE_NAME rescue model.name end).downcase
  end

  def type_name_plural
    (begin self.class::TYPE_NAME_PLURAL rescue "#{type_name}#{'jsxz'.include?(type_name[-1]) ? 'e' : ''}s" end).downcase
  end

  def add
    puts "What #{type_name} do you want to add?"
    name = clean_gets
    item = model.create(name: name)
    if item.new_record?
      puts item.errors.full_messages
    else
      puts "#{name} has been added to the list of #{type_name_plural} in the league"
    end
  end

  def list
    puts "=============="
    puts type_name_plural.upcase
    puts "=============="
    items.each_with_index do |item, index|
      puts "#{index + 1}. #{item.name}"
    end
  end

  def edit
    puts "Which #{type_name} do you want to edit? (Number)"
    item = get_item_from_user
    if item
      name = item.name
      puts "Which attribute of #{name} would you like to change?"
      attribute = clean_gets
      if item.respond_to?(attribute)
        old_value = item.send(attribute)
        puts "What is the new value for #{name}'s #{attribute}? (Old value: #{old_value})"
        value = clean_gets
        begin
          model.update(item.id, :name=> value)
          puts "#{name}'s #{attribute} has been changed from #{old_value} to #{value}"
        rescue
          puts "That is not a valid value for #{name}'s #{attribute}"
        end
      else
        puts "That is not a valid attribute"
      end
    end
  end

  def delete
    puts "Which #{type_name} do you want to delete? (Number)"
    item = get_item_from_user
    if item
      puts "#{item.name}: Are your SURE you wish to PERMANENTLY DELETE this #{type_name}? (y/N)"
      input = clean_gets.downcase
      if input == 'y'
        item.destroy
        puts "#{item.name} has been deleted."
      else
        puts "#{item.name} has NOT been deleted."
      end
    end
  end

  def get_item_from_user
    index = clean_gets.to_i
    item = items[index-1]
    puts "That is not a valid selection." if item.nil?
    item
  end

  def items
    # @items ||= model.all
    model.all
  end

end