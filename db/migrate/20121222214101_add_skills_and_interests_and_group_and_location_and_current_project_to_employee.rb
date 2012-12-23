class AddSkillsAndInterestsAndGroupAndLocationAndCurrentProjectToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :skills, :string
    add_column :employees, :interests, :string
    add_column :employees, :group, :string
    add_column :employees, :location, :string
    add_column :employees, :current_project, :string
  end
end
