class CreateMatchSkills < ActiveRecord::Migration
  def change
    create_table :skills_interest do |t|
      t.integer :employee_id
      t.integer :skill_id
      t.boolean :skills_interested_in

      t.timestamps
    end
  end
end
