class DropTable < ActiveRecord::Migration
  def up
  	drop_table :Reqstates
  end

  def down
  end
end
