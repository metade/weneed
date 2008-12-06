class ExpressionsController < ApplicationController
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json do
        data = Address.expression_data
        render :json => data
      end
    end
    
  end
end
