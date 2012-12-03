class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :employee_id
      t.string :group
      t.string :location
      t.string :skills_needed
      t.date :start_date
      t.date :stop_date
      t.string :request
      t.string :client
      t.string :project

      t.timestamps
    end
  end
end
