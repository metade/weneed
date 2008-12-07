class Need < ActiveRecord::Base
  acts_as_nested_set
  has_and_belongs_to_many :users
  attr_accessor :child_count
  
  def self.grouped_by_latlng
    result = {}
    needs = self.find_by_sql(%[SELECT n.*, a.latlng, COUNT(n.id) AS 'c', 0 AS 'child_count' FROM addresses a
      JOIN users u ON a.user_id=u.id
      JOIN needs_users nu ON u.id=nu.user_id
      JOIN needs n ON nu.need_id=n.id
      GROUP BY latlng, n.id
      ORDER BY latlng, n.id;])
    
    current_parent = nil
    needs.each do |need|
      # FIXME: this bit should be done in SQL      
      need.c, need.child_count = need.c.to_i, need.child_count.to_i
      current_parent = need if need.parent.nil?
      current_parent.child_count += need.c
      
      result[need.latlng] ||= []
      result[need.latlng] << need
    end
    result
  end
  
  def self.summary(needs)
    rts = roots
    rts.each do |r|
      need = needs.detect { |n| n.id==r.id }      
      r.child_count = (need.nil?) ? 0 : need.child_count
    end
    rts
  end
end
