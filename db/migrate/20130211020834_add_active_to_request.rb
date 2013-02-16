class AddActiveToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :active, :string
  end
end
