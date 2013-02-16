class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :requests, :status, :filled
  end
end
