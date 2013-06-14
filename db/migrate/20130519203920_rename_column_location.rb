class RenameColumnLocation< ActiveRecord::Migration
  def up
  	rename_column :employees, :location, :location_id
  	rename_column :requests, :location, :location_id
  end

  def down
  end
end
