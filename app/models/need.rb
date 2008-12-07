class Need < ActiveRecord::Base
  acts_as_nested_set
  has_and_belongs_to_many :users
  
  def self.grouped_by_latlng
    result = {}
    needs = self.find_by_sql(%[SELECT n.*, a.latlng, COUNT(n.id) AS 'c', 0 AS 'total_c' FROM addresses a
      JOIN users u ON a.user_id=u.id
      JOIN needs_users nu ON u.id=nu.user_id
      JOIN needs n ON nu.need_id=n.id
      GROUP BY latlng, n.id
      ORDER BY latlng, n.id;])
    
    current_parent = nil
    needs.each do |need|
      need.c, need.total_c = need.c.to_i, need.total_c.to_i
      current_parent = need if need.parent.nil?
      current_parent.total_c += need.c
      
      result[need.latlng] ||= []
      result[need.latlng] << need
    end
    result
  end
end
