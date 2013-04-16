class AddLevelToEmployeeSkills < ActiveRecord::Migration
  def change
    add_column :employee_skills, :level, :integer, :default => 0
  end
end
