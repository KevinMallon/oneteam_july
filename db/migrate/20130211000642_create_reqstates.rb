class CreateReqstates < ActiveRecord::Migration
  def change
    create_table :reqstates do |t|
      t.string :open
      t.string :closed
      t.integer :request_id

      t.timestamps
    end
  end
end
