require 'spec_helper'

describe "TargetSkills" do
  describe "GET /target_skills" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get target_skills_path
      response.status.should be(200)
    end
  end
end
