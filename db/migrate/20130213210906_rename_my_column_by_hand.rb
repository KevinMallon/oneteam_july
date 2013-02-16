class RenameMyColumnByHand < ActiveRecord::Migration
  def self.up
    rename_column :requests, :request, :content
  end

  def self.down
    rename_column :requests, :content, :request
  end
end