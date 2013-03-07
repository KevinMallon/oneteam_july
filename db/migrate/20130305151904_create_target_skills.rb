class CreateTargetSkills < ActiveRecord::Migration
  def change
    create_table :target_skills do |t|
      t.integer :employee_id
      t.integer :skill_id

      t.timestamps
    end
  end
end
