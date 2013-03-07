class CreateSkillsCurrents < ActiveRecord::Migration
  def change
    create_table :skills_create do |t|
      t.integer :employee_id
      t.integer :skill_id
      t.boolean :current_skills

      t.timestamps
    end
  end
end
