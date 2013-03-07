require 'spec_helper'

describe "employee_skills/index" do
  before(:each) do
    assign(:employee_skills, [
      stub_model(EmployeeSkill,
        :employee_id => 1,
        :skill_id => 2
      ),
      stub_model(EmployeeSkill,
        :employee_id => 1,
        :skill_id => 2
      )
    ])
  end

  it "renders a list of employee_skills" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
