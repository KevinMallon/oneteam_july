class AddProficiencyToEmployeeSkills < ActiveRecord::Migration
  def change
    add_column :employee_skills, :proficiency, :integer, :default => 0
  end
end
