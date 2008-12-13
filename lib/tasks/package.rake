# require 'open-uri'
require 'action_controller'
require 'action_controller/integration'

desc "Package the demonstrator into a stand-alone zip file"
task :package => [:environment] do
  
  weneed = File.join(RAILS_ROOT, 'tmp', 'weneed')
  rm_rf(weneed)
  mkdir_p(File.join(weneed, 'expressions'))
  cp(File.join(RAILS_ROOT, 'public', 'index.html'), weneed)
  cp(File.join(RAILS_ROOT, 'public', '__history__.html'), weneed)
  cp_r(File.join(RAILS_ROOT, 'public', 'stylesheets'), weneed)
  cp_r(File.join(RAILS_ROOT, 'public', 'images'), weneed)
  cp_r(File.join(RAILS_ROOT, 'public', 'charts'), weneed)

  app = ActionController::Integration::Session.new
  app.get '/expressions/data.json'
  File.open(File.join(weneed, 'expressions', 'data.json'), 'w') do |f|
    f.puts(app.response.body)
  end
end
