class CreateEmployeeSkillEvaluations < ActiveRecord::Migration
  def change
    create_table :employee_skill_evaluations do |t|
      t.integer :response_id
      t.integer :skill_id
      t.integer :experience_points
      t.integer :assessed_proficiency

      t.timestamps
    end
  end
end
