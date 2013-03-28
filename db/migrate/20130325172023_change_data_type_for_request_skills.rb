class ChangeDataTypeForRequestSkills < ActiveRecord::Migration
def self.up
	change_table :request_skills do |t|
	t.change :skills_needed, :integer
	end
end
 
def self.down
	change_table :request_skills do |t|
	t.change :skills_needed, :boolean
	end
end
end
