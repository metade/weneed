require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/needs/index.html.erb" do
  include NeedsHelper
  
  before(:each) do
    assigns[:needs] = [
      stub_model(Need),
      stub_model(Need)
    ]
  end

  it "should render list of needs" do
    render "/needs/index.html.erb"
  end
end

