require "spec_helper"

describe Charmkit do
  before(:all) do
    @plugin = Class.new { include Charmkit::Plugin }
  end

  it "has a version number" do
    expect(Charmkit::VERSION).not_to be nil
  end
  it "has a file method" do
    expect(@plugin).to respond_to :file
  end
  it "has a react_on method" do
    expect(@plugin).to respond_to :react_on
  end

end
