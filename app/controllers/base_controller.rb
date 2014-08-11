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
    parameters = {name: name}
    attributes.each{ |attribute|
      puts "#{attribute_formatted(attribute)}:"
      value = clean_gets
      parameters.merge!(attribute.to_sym => value) if value.size > 0
    }
    item = model.create(parameters)
    if item.new_record?
      puts item.errors.full_messages
    else
      puts "#{name} has been added to the list of #{type_name_plural} in the league"
    end
  end

  def list
    puts <<EOS
==============
#{type_name_plural.upcase}
==============
EOS

    items.each_with_index do |item, index|
      puts "#{index + 1}. #{item.name}"
    end
  end

  def edit
    puts "Which #{type_name} do you want to edit? (Number or Name)"
    item = get_item_from_user
    if item
      name = item.name
      puts "Which attribute of #{name} would you like to change? (Number)"
      attributes_formatted(false).each_with_index{ |attribute, index|
        puts "#{index+1}. #{attribute}"
      }
      attribute_index = clean_gets.to_i
      attribute = attributes(false)[attribute_index-1]
      if item.respond_to?(attribute)
        attribute_name = attribute_formatted(attribute, false)
        old_value = item.send(attribute)
        puts "What is the new value for #{name}'s #{attribute_name}? (Old value: #{old_value})"
        value = clean_gets
        begin
          model.update(item.id, attribute.to_sym=> value)
          puts "#{name}'s #{attribute_name} has been changed from #{old_value} to #{value}"
        rescue
          puts "That is not a valid value for #{name}'s #{attribute_name}"
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
    input = clean_gets
    item = model.find_by(name: input)
    # item = get_item_by_name(input)
    if item.nil?
      index = input.to_i
      item = items[index-1] if index.between?(1, items.size)
    end
    puts "That is not a valid selection." if item.nil?
    item
  end

  # def get_item_by_name(name)
  #   model.find_by(name: name)
  # end

  def items
    # @items ||= model.all
    model.all.sort_by{|item| item.name.downcase}
  end

  def attribute_formatted(attribute, should_capitalize=true)
    attribute = attribute.gsub(/_/, ' ')
    attribute.capitalize! if should_capitalize
    attribute
  end

  def attributes(should_ignore_name=true)
    disregarded_attributes = ['id']
    disregarded_attributes.concat(['name']) if should_ignore_name
    value = model.column_names.select{|attribute| !disregarded_attributes.include?(attribute)}
  end

  def attributes_formatted(should_ignore_name=true)
    attributes(should_ignore_name).map{|attribute| attribute_formatted(attribute)}
  end

end