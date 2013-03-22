class RemoveCurrentSkillsFromEmployees < ActiveRecord::Migration
  def up
  	remove_column :employees, :current_skills, :skills_interested_in
  end

  def down
  end
end
