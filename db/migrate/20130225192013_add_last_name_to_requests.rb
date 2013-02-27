class AddLastNameToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :last_name, :string
  end
end
