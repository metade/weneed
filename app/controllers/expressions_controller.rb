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
    image_url = chart.to_url.gsub('&amp;', '&')
    
    # Cache image locally so it can be rendered in Exhibit
    image_key = Digest::MD5.hexdigest(image_url)
    file_path = File.join(RAILS_ROOT, 'public', 'charts', "#{image_key}.png")
    unless File.exist? file_path
      `curl -s -o #{file_path} "#{image_url}"`
      sleep 0.1
    end
    "http://we-need.org/sicamp/charts/#{image_key}.png"
  end
end
