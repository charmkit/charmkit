require "spec_helper"

module Charmkit
  class SimplePlugin
    include Charmkit::Plugin
    depends_on "nginx-full"
  end
end


describe Charmkit do
  before(:all) do
    @plugin = SimplePlugin.new
  end

  it "has a version number" do
    expect(Charmkit::VERSION).not_to be nil
  end

  it "has a file method" do
    expect(@plugin).to respond_to :file
  end

  it "has a run! method" do
    expect(@plugin).to respond_to :run!
  end

  it "has a react_on method" do
    expect(@plugin).to respond_to :react_to
  end

  it "has depends_on method" do
    expect(@plugin).to respond_to :depends_on
  end

  # it "has nginx dependency listed" do
  #   expect(@plugin.dependences.first.name).to equal 'nginx-full'
  # end

end
