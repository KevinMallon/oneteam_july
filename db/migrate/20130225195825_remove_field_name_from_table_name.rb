class RemoveFieldNameFromTableName < ActiveRecord::Migration
def self.up
  remove_column :requests, :last_name
end
end
