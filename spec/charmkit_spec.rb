require "spec_helper"

class SP < Charmkit::Plugin
  depends_on 'php'
end

describe SP do
  before(:all) do
    @plugin = SP.new
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
  #   puts @plugin
  #   expect(@plugin.dependencies.first.name).to eq 'nginx-full'
  # end

end
