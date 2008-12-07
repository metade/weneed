class ExpressionsController < ApplicationController
  def data
    needs_by_latlng = Need.grouped_by_latlng
    data = needs_by_latlng.keys.map do |latlng|
      needs = needs_by_latlng[latlng]
      {
        :latlng => latlng,
        :needs => needs.map { |n| n.name },
        :count => needs.size
      }
    end
  end

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
