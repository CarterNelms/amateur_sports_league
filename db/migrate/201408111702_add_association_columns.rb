class AddAssociationColumns < ActiveRecord::Migration

  def change
    change_table "sports", force: true do |t|
      t.references :teams
    end

    change_table "teams", force: true do |t|
      t.references :sport
      t.references :players
      t.references :captain
    end
  end

end
