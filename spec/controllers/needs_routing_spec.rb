require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NeedsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "needs", :action => "index").should == "/needs"
    end
  
    it "should map #new" do
      route_for(:controller => "needs", :action => "new").should == "/needs/new"
    end
  
    it "should map #show" do
      route_for(:controller => "needs", :action => "show", :id => 1).should == "/needs/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "needs", :action => "edit", :id => 1).should == "/needs/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "needs", :action => "update", :id => 1).should == "/needs/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "needs", :action => "destroy", :id => 1).should == "/needs/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/needs").should == {:controller => "needs", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/needs/new").should == {:controller => "needs", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/needs").should == {:controller => "needs", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/needs/1").should == {:controller => "needs", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/needs/1/edit").should == {:controller => "needs", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/needs/1").should == {:controller => "needs", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/needs/1").should == {:controller => "needs", :action => "destroy", :id => "1"}
    end
  end
end
