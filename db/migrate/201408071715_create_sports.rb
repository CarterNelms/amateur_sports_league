class CreateSports < ActiveRecord::Migration

  def change
    create_table "sports", force: true do |t|
      t.string "name"
    end
  end

end
