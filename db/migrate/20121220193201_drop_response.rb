class DropResponse < ActiveRecord::Migration
    def up
        drop_table :Responses
    end

    def down
        create_table :Responses do |t|
      t.integer :employee_id
      t.integer :request_id
      t.string :response

      t.timestamps
        end
    end
end
