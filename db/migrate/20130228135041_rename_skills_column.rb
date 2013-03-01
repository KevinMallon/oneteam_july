class RenameSkillsColumn < ActiveRecord::Migration
  def up
  	rename_column :employees, :skills, :current_skills
  end

  def down
  end
end
