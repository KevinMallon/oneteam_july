require 'spec_helper'

describe "employee_skills/show" do
  before(:each) do
    @employee_skill = assign(:employee_skill, stub_model(EmployeeSkill,
      :employee_id => 1,
      :skill_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
