class BaseController

  def navigate_menu(command, user)
    Router.send("navigate_#{type_name_plural}_menu", *[self, command, user])
  end

  def list
    # puts @parent.name if @parent
    puts <<EOS
==============
EOS
    if @parent
      puts <<EOS
#{@parent.name}
EOS
    end
    puts <<EOS
#{type_name_plural.upcase}
==============
EOS
    items.each_with_index do |item, index|
      puts "#{index + 1}. #{attributes.include?("name") ? item.name : "#{item.first_name} #{item.last_name}"}"
    end
  end

  def get_by_index(index)
    selectable_items = items
    selectable_items[index-1] if index.between?(1, selectable_items.size)
  end

  def add(name=nil, creator=nil)
    if name.nil?
      puts "What #{type_name} do you want to add?"
      name = clean_gets
    end
    unique_title_attribute_name = attributes.include?('username') ? :username : :name
    parameters = {unique_title_attribute_name => name}
    attributes(false).each{ |attribute|
      if ["is_"].include?(attribute[0,3])
        case attribute[3,attribute.length-1]
        when "male"
          puts "Male(1) or Female(2):"
          input = clean_gets
          case input.downcase
          when 'm', 'male', '1'
            value = "1"
          when 'f', 'female', '2'
            value = "0"
          else
            value = ""
          end
        end
      else
        puts "#{attribute_formatted(attribute)}:"
        value = clean_gets
      end
      parameters.merge!(attribute.to_sym => value) if value.size > 0
    }
    item = model.create(parameters)
    if @parent
      parent_type_name = "#{@parent.class.name.downcase}"
      parent_type_plural_name = "#{parent_type_name}s"
      if model.column_names.include?("#{parent_type_name}_id")
        puts "A"
        item.instance_variable_set("@#{parent_type_name}", @parent)
      elsif model.column_names.include?("#{parent_type_plural_name}_id")
        puts "B"
        item.instance_variable_set("@#{parent_type_plural_name}", item.instance_variable_get("@#{parent_type_plural_name}").concat(@parent))
      end
      puts item.instance_variable_get("@#{parent_type_name}").name
      item.save!
    end
    case model.name.downcase
    when "team"
      membership = Membership.create(team: item, player: creator)
      creator.memberships << membership
      item.memberships << membership
      begin
        item.captain = membership
      rescue
        item.destroy
      end
    end
    # item.instance_variable_set("@#{parent.class.name.downcase}", @parent) if @parent
    if item.new_record?
      puts item.errors.full_messages
      false
    else
      puts "#{name} has been added to the list of #{type_name_plural} in the league"
      item
    end
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
      if input == 'y' || input == 'yes'
        item.destroy
        puts "#{item.name} has been deleted."
      else
        puts "#{item.name} has NOT been deleted."
      end
    end
  end

  def get_from_user
    input = clean_gets
    parameters = {name: input}
    if @parent
      parameters.merge!(parent_id_name => @parent.id)
    end
    item = model.find_by(parameters)
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

  def parent_id_name
    "#{@parent.class.name.downcase}_id"
  end

  def parent_ids(item)
    if item.respond_to?(parent_id_name)
      Array(item.send(parent_id_name))
    else
      Array(item.send("#{@parent.class.name.downcase}s_id"))
    end
  end

  def items
    items_to_return = items_all
    if @parent
      items_to_return.select!{|item| parent_ids(item).include?(@parent.id)}
    end
    items_to_return
  end

  def items_all
    model.all.sort_by{|item| attributes.include?("last_name") ? item.last_name : item.name}
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
    disregarded_attributes.concat(['name', 'username']) unless should_include_name
    value = model.column_names.select{|attribute| !(disregarded_attributes.include?(attribute) || attribute.include?("_id"))}
  end

  def attributes_formatted(should_include_name=true)
    attributes(should_include_name).map{|attribute| attribute_formatted(attribute)}
  end

end