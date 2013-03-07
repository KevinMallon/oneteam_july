class RenameTable < ActiveRecord::Migration
  def self.up
    rename_table :skills_create, :employee_skills_current
  end

 def self.down
    rename_table :employee_skills_current, :skills_create
 end
end
 