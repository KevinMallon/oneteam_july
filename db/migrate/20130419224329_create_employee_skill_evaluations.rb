class CreateEmployeeSkillEvaluations < ActiveRecord::Migration
  def change
    create_table :employee_skill_evaluations do |t|
      t.integer :response_id
      t.integer :skill_id
      t.integer :assigned_skill_level
      t.integer :skill_experience_points

      t.timestamps
    end
  end
end
