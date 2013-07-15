class CreateEmployeeLocations < ActiveRecord::Migration
  def change
    create_table :employee_locations do |t|
      t.integer :employee_id
      t.integer :location_id

      t.timestamps
    end
  end
end
