class DropEmployeeSkillsCurrent < ActiveRecord::Migration
  def up
  	drop_table :employee_skills_current
  end

  def down
  end
end
