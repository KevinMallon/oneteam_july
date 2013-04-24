class DropTableEmployeeSkillEvaluations < ActiveRecord::Migration
  def up
  	drop_table :employee_skill_evaluations
  end

  def down
  end
end
