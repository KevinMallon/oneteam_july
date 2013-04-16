class RemoveLevelFromEmployeeSkills < ActiveRecord::Migration
  def up
  	remove_column :employee_skills, :level
  end

  def down
  end
end
