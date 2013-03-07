require 'spec_helper'

describe "employee_skills/edit" do
  before(:each) do
    @employee_skill = assign(:employee_skill, stub_model(EmployeeSkill,
      :employee_id => 1,
      :skill_id => 1
    ))
  end

  it "renders the edit employee_skill form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => employee_skills_path(@employee_skill), :method => "post" do
      assert_select "input#employee_skill_employee_id", :name => "employee_skill[employee_id]"
      assert_select "input#employee_skill_skill_id", :name => "employee_skill[skill_id]"
    end
  end
end
