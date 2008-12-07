class ExpressionsController < ApplicationController
  def data
    template = ERB.new(File.read(File.join(RAILS_ROOT, 'app', 'views', 'needs', '_need.html.erb')))
    needs_by_latlng = Need.grouped_by_latlng
    max_count = needs_by_latlng.values.map { |n| n.size }.max
    data = needs_by_latlng.keys.map do |latlng|
      needs = needs_by_latlng[latlng]
      summary = Need.summary(needs)
      next if summary.nil?
      top_level_needs = summary.select { |n| n.child_count > 0 }
      p top_level_needs
      next if top_level_needs.empty? # wtf??? shouldn't be empty
      {
        :label => latlng,
        :latlng => latlng,
        :needs => top_level_needs.map { |n| n.name },
        :count => needs.size,
        :imageURL => image_for_needs(summary, max_count, needs.size),
        :details => template.result(binding)        
      }
    end
    data.compact!
    
    respond_to do |format|
      format.json { render :json => { :items => data } }
    end
  end

  def index
    render :layout => false
  end
  
  protected
  def image_for_needs(needs, max_count, count)
    chart = GoogleChart.new
    chart.type = :pie
    size = 30+(70*(count/max_count.to_f)).to_i
    chart.height, chart.width = size, size
    chart.data = needs.map { |n| n.child_count }
    image_url = chart.to_url.gsub('&amp;', '&')
    
    # Cache image locally so it can be rendered in Exhibit
    image_key = Digest::MD5.hexdigest(image_url)
    file_path = File.join(RAILS_ROOT, 'public', 'charts', "#{image_key}.png")
    unless File.exist? file_path
      `curl -s -o #{file_path} "#{image_url}"`
      sleep 0.1
    end
    "http://metade.org/code/weneed/charts/#{image_key}.png"
  end
end
