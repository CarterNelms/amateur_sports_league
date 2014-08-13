class CreatePlayers < ActiveRecord::Migration

  def change
    create_table "players", force: true do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.integer :age
      t.integer :is_male
      t.references :teams
      t.references :sports
    end
  end

end
