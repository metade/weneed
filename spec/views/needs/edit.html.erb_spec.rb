require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/needs/edit.html.erb" do
  include NeedsHelper
  
  before(:each) do
    assigns[:need] = @need = stub_model(Need,
      :new_record? => false
    )
  end

  it "should render edit form" do
    render "/needs/edit.html.erb"
    
    response.should have_tag("form[action=#{need_path(@need)}][method=post]") do
    end
  end
end


