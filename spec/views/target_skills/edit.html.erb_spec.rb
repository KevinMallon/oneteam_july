require 'spec_helper'

describe "target_skills/edit" do
  before(:each) do
    @target_skill = assign(:target_skill, stub_model(TargetSkill,
      :employee_id => 1,
      :skill_id => 1
    ))
  end

  it "renders the edit target_skill form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => target_skills_path(@target_skill), :method => "post" do
      assert_select "input#target_skill_employee_id", :name => "target_skill[employee_id]"
      assert_select "input#target_skill_skill_id", :name => "target_skill[skill_id]"
    end
  end
end
