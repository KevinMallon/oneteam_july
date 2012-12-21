class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :employee_id
      t.integer :request_id
      t.string :response

      t.timestamps
    end
  end
end
