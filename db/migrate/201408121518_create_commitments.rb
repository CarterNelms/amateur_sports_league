class CreateCommitments < ActiveRecord::Migration

  def change
    create_table "commitments", force: true do |t|
      t.references :team
      t.references :player
      t.references :sport
    end

    change_table "teams", force: true do |t|
      t.remove :players
      t.references :commitments
    end

    change_table "players", force: true do |t|
      t.remove :teams
      t.references :commitments
    end
  end

end
