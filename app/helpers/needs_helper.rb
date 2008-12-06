module NeedsHelper

  def nested_set_list(collection, &block) 
    items = collection.to_a.compact 
    return "" if items.blank? 
    lft, rgt = items.first.left_col_name, items.first.right_col_name 
    stack, html = [], "<ul>" 
    items.sort_by(&lft.to_sym).each do |item| 
    unless stack.empty? 
      if item[rgt] < stack.last[rgt] 
        html << "\n#{'  ' * stack.size}<ul>" 
      else 
        stack.pop and html << "</li>\n" 
      end 
      while stack.last && item[rgt] > stack.last[rgt] 
        stack.pop and html << "#{'  ' * (stack.size + 1)}</ul></li>\n" 
      end 
    end 
    stack << item 
    html << "\n#{'  ' * stack.size}<li>#{yield(item)}" 
    end 
    stack.pop and html << "</li>\n" 
    stack.size.times { stack.pop and html << "#{'  ' * (stack.size + 1)}</ul></li>\n" } 
    html << "</ul>" 
  end
end
