class Address < ActiveRecord::Base
  belongs_to :user
  acts_as_mappable :auto_geocode => true
  
  before_save do |a|
    a.latlng = "#{a.lat},#{a.lng}"
  end
end
