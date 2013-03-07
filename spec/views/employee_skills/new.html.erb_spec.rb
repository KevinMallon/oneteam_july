require 'spec_helper'

describe "employee_skills/new" do
  before(:each) do
    assign(:employee_skill, stub_model(EmployeeSkill,
      :employee_id => 1,
      :skill_id => 1
    ).as_new_record)
  end

  it "renders new employee_skill form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => employee_skills_path, :method => "post" do
      assert_select "input#employee_skill_employee_id", :name => "employee_skill[employee_id]"
      assert_select "input#employee_skill_skill_id", :name => "employee_skill[skill_id]"
    end
  end
end
