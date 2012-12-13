require 'spec_helper'

describe Employee do

  before do
    @employee = Employee.new(name: "Example User", email: "employee@example.com")
  end

  subject { @employee }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }

end