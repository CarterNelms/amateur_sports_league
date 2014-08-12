class BaseController

  def navigate_menu(command)
    Router.send("navigate_#{type_name_plural}_menu", *[self, command])
  end

  def list
    # puts @parent.name if @parent
    if @parent
      puts <<EOS
==============
#{@parent.name}
==============
EOS
    end
    puts <<EOS
==============
#{type_name_plural.upcase}
==============
EOS

    items.each_with_index do |item, index|
      puts "#{index + 1}. #{item.name}"
    end
  end

  def get_by_index(index)
    items[index-1] if index.between?(1, items.size)
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
    attributes(false).each{ |attribute|
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

  def edit
    puts "Which #{type_name} do you want to edit? (Number or Name)"
    item = get_from_user
    if item
      name = item.name
      puts "Which attribute of #{name} would you like to change? (Number or Name)"
      attributes_formatted.each_with_index{ |attribute, index|
        puts "#{index+1}. #{attribute}"
      }
      input = clean_gets
      attribute = attributes_formatted.include?(input) ? input : nil
      attribute ||= attributes[input.to_i-1] if input.to_i.between?(1,attributes.size)
      attribute = attribute_unformatted(attribute.to_s)
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
    puts "Which #{type_name} do you want to delete? (Number or Name)"
    item = get_from_user
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

  def get_from_user
    input = clean_gets
    item = model.find_by(name: input)
    # item = get_by_name(input)
    if item.nil?
      item = get_by_index(input.to_i)
    end
    puts "That is not a valid selection." if item.nil?
    item
  end

  # def get_by_name(name)
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

  def attribute_unformatted(attribute)
    attribute.gsub(/\s/, '_').downcase
  end

  def attributes(should_include_name=true)
    disregarded_attributes = ['id']
    disregarded_attributes.concat(['name']) unless should_include_name
    value = model.column_names.select{|attribute| !(disregarded_attributes.include?(attribute) || attribute.include?("_id"))}
  end

  def attributes_formatted(should_include_name=true)
    attributes(should_include_name).map{|attribute| attribute_formatted(attribute)}
  end

end