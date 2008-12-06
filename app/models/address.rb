class Address < ActiveRecord::Base
  belongs_to :user
  acts_as_mappable :auto_geocode => true
  
  def self.expression_data
    [
      {
        :lat => 51.4665368, :lng => -0.1624088,
        :image => 'http://chart.apis.google.com/chart?cht=p&chd=t:60,40&chs=100x100',
        :needs => [ 'foo', 'bar' ],
        :text => [ 'a b c' ],
      }
    ]
    
  end
end
