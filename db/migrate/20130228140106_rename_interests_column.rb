class RenameInterestsColumn < ActiveRecord::Migration
  def up
  	rename_column :employees, :interests, :skills_interested_in
  end

  def down
  end
end
