class RenameResponseId < ActiveRecord::Migration
  def up
  	rename_column :employee_skill_evaluations, :response_id, :evaluation_id
  end

  def down
  end
end
