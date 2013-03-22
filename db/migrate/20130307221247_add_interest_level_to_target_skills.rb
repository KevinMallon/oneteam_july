class AddInterestLevelToTargetSkills < ActiveRecord::Migration
  def change
    add_column :target_skills, :interest_level, :integer, :default => 0
  end
end
