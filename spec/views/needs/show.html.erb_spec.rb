require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/needs/show.html.erb" do
  include NeedsHelper
  
  before(:each) do
    assigns[:need] = @need = stub_model(Need)
  end

  it "should render attributes in <p>" do
    render "/needs/show.html.erb"
  end
end

