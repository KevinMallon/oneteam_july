class RenameProficiencyLevel < ActiveRecord::Migration
  def up
  	rename_column :employee_skills, :proficiency, :level
  end

  def down
  end
end
