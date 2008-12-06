require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NeedsController do

  def mock_need(stubs={})
    @mock_need ||= mock_model(Need, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all needs as @needs" do
      Need.should_receive(:find).with(:all).and_return([mock_need])
      get :index
      assigns[:needs].should == [mock_need]
    end

    describe "with mime type of xml" do
  
      it "should render all needs as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Need.should_receive(:find).with(:all).and_return(needs = mock("Array of Needs"))
        needs.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested need as @need" do
      Need.should_receive(:find).with("37").and_return(mock_need)
      get :show, :id => "37"
      assigns[:need].should equal(mock_need)
    end
    
    describe "with mime type of xml" do

      it "should render the requested need as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Need.should_receive(:find).with("37").and_return(mock_need)
        mock_need.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new need as @need" do
      Need.should_receive(:new).and_return(mock_need)
      get :new
      assigns[:need].should equal(mock_need)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested need as @need" do
      Need.should_receive(:find).with("37").and_return(mock_need)
      get :edit, :id => "37"
      assigns[:need].should equal(mock_need)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created need as @need" do
        Need.should_receive(:new).with({'these' => 'params'}).and_return(mock_need(:save => true))
        post :create, :need => {:these => 'params'}
        assigns(:need).should equal(mock_need)
      end

      it "should redirect to the created need" do
        Need.stub!(:new).and_return(mock_need(:save => true))
        post :create, :need => {}
        response.should redirect_to(need_url(mock_need))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved need as @need" do
        Need.stub!(:new).with({'these' => 'params'}).and_return(mock_need(:save => false))
        post :create, :need => {:these => 'params'}
        assigns(:need).should equal(mock_need)
      end

      it "should re-render the 'new' template" do
        Need.stub!(:new).and_return(mock_need(:save => false))
        post :create, :need => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested need" do
        Need.should_receive(:find).with("37").and_return(mock_need)
        mock_need.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :need => {:these => 'params'}
      end

      it "should expose the requested need as @need" do
        Need.stub!(:find).and_return(mock_need(:update_attributes => true))
        put :update, :id => "1"
        assigns(:need).should equal(mock_need)
      end

      it "should redirect to the need" do
        Need.stub!(:find).and_return(mock_need(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(need_url(mock_need))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested need" do
        Need.should_receive(:find).with("37").and_return(mock_need)
        mock_need.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :need => {:these => 'params'}
      end

      it "should expose the need as @need" do
        Need.stub!(:find).and_return(mock_need(:update_attributes => false))
        put :update, :id => "1"
        assigns(:need).should equal(mock_need)
      end

      it "should re-render the 'edit' template" do
        Need.stub!(:find).and_return(mock_need(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested need" do
      Need.should_receive(:find).with("37").and_return(mock_need)
      mock_need.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the needs list" do
      Need.stub!(:find).and_return(mock_need(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(needs_url)
    end

  end

end
