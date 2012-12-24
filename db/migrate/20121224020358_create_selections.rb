class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.integer :request_id
      t.integer :employee_id
      t.string :comments

      t.timestamps
    end
  end
end
