class AddDepartmentToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :department, :string
    add_column :employees, :supervisor, :string
    add_column :employees, :years_at_company, :integer
    add_column :employees, :description, :string
    add_column :employees, :job_title, :string
  end
end
