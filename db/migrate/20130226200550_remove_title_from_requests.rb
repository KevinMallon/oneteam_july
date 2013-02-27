class RemoveTitleFromRequests < ActiveRecord::Migration
def self.up
  remove_column :requests, :title
end
end
