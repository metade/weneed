require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/needs/new.html.erb" do
  include NeedsHelper
  
  before(:each) do
    assigns[:need] = stub_model(Need,
      :new_record? => true
    )
  end

  it "should render new form" do
    render "/needs/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", needs_path) do
    end
  end
end


