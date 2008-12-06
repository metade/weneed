
task :load_needs => [:environment] do
  Need.find(:all).each { |n| n.destroy }
  current_parent = nil
  File.read('needs.txt').each do |line|
    next unless line =~ /( *?)(\w.*)/
    spacing, name = $1, $2
    
    need = Need.new(:name => name)
    need.save
    
    p [line, spacing]
    if (spacing and spacing.size==0)
      current_parent = need
    else
      current_parent.add_child(need)
    end
    need.save
    current_parent.save
  end
end
