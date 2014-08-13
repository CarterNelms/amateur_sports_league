class RemoveStrayColumns < ActiveRecord::Migration

  def change
    rename_column :players, :commitments_id, :memberships_id
    rename_column :teams, :commitments_id, :memberships_id
    remove_column :players, :team_id
  end

end
