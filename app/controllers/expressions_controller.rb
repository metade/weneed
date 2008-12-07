class ExpressionsController < ApplicationController
  def data
    needs_by_latlng = Need.grouped_by_latlng
    data = needs_by_latlng.keys.map do |latlng|
      needs = needs_by_latlng[latlng]
      {
        :latlng => latlng,
        :needs => needs.map { |n| n.name },
        :count => needs.size,
        :imageURL => image_for_needs(Need.summary(needs))
      }
    end
    
    respond_to do |format|
      format.json { render :json => data }
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
  
  protected
  def image_for_needs(needs)
    chart = GoogleChart.new
    chart.type = :pie
    chart.height, chart.width = 100, 100
    chart.data = needs.map { |n| n.child_count }
    chart.to_url.gsub('&amp;', '&')
  end
end
