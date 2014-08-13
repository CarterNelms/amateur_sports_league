class RenameCommitmentsToMigrations < ActiveRecord::Migration

  def change
    rename_table :commitments, :memberships
  end

end
