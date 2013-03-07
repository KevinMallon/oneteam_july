class RenameSkillsInterest < ActiveRecord::Migration
  def self.up
    rename_table :skills_interest, :employee_skills_interested_in
  end

 def self.down
    rename_table :employee_skills_interested_in, :skills_interest
 end
end