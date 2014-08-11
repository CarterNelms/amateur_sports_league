class CreateTeams < ActiveRecord::Migration

  def change
    create_table "teams", force: true do |t|
      t.string "name"
    end
  end

end
