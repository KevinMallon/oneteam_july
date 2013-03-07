class DropEmployeeSkillsInterestedIn < ActiveRecord::Migration
  def up
  	  drop_table :employee_skills_interested_in
  end

  def down
  end
end
