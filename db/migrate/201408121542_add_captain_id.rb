class AddCaptainId < ActiveRecord::Migration

  def change
    change_table "players", force: true do |t|
      t.references :team
    end
  end

end
