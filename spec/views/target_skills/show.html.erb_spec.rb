require 'spec_helper'

describe "target_skills/show" do
  before(:each) do
    @target_skill = assign(:target_skill, stub_model(TargetSkill,
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
