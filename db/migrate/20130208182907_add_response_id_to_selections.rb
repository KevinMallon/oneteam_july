class AddResponseIdToSelections < ActiveRecord::Migration
  def change
    add_column :selections, :response_id, :integer
  end
end
