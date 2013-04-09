class RenameInterestLevel < ActiveRecord::Migration
  def up
  	rename_column :target_skills, :interest_level, :level
  end

  def down
  end
end
