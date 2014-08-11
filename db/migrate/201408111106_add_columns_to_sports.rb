class AddColumnsToSports < ActiveRecord::Migration

  def change
    add_column :sports, :minimum_team_size, :integer, :default=>0
    add_column :sports, :maximum_team_size, :integer, :default=>100
    add_column :sports, :minimum_number_of_teams, :integer, :default=>0
    add_column :sports, :maximum_number_of_teams, :integer, :default=>100
  end

end
