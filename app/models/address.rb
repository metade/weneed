class Address < ActiveRecord::Base
  belongs_to :user
  acts_as_mappable :auto_geocode => true
  
  before_save do |a|
    a.latlng = "#{a.lat},#{a.lng}"
  end
  
  def self.latlngs
    # hash = {}
    # sql = %[
    #   SELECT n.*, a.latlng, COUNT(n.id) AS 'c' FROM addresses a
    #   JOIN users u ON a.user_id=u.id
    #   JOIN needs_users nu ON u.id=nu.user_id
    #   JOIN needs n ON nu.need_id=n.id
    #   GROUP BY latlng, n.id
    #   ORDER BY latlng, n.id;]
    # foo = Need.find_by_sql(sql)
    # p foo
    # p foo.first.latlng
    # connection.execute(sql).each do |row|
    #   latlng, need = row[0], row[1]
    #   hash[row.first] ||= []
    #   hash[row.first] << need
    # end
    needs_by_latlng = Need.grouped_by_latlng
    needs_by_latlng.keys.map do |latlng|
      needs = needs_by_latlng[latlng]
      {
        :latlng => latlng,
        :needs => needs.map { |n| n.name },
        :count => needs.size
      }
    end
  end
  
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
