class RemoveFilledFromRequest < ActiveRecord::Migration
  def up
    remove_column :requests, :filled
  end

  def down
    add_column :requests, :filled, :string
  end
end
