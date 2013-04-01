class RemoveColumn < ActiveRecord::Migration
  def up
  	remove_column :request_skills, :skills_needed
  end

  def down
  end
end
