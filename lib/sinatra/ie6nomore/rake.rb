require 'rake'
require 'sinatra/ie6nomore'

namespace :ie6nomore do
  
  desc "Copy images from gem to ../public/images/ie6nomore dir"
  task :copy_images do 
    src_dir = "#{Sinatra::IE6NoMore.gem_root_path}/files/"
    dest_dir = "#{Dir.pwd}/public/images/ie6nomore"
    
    puts "\n Copying images from #{src_dir} to #{dest_dir}"
    sh "mkdir -p #{dest_dir}" unless test(?e, dest_dir)
    sh "cp -r #{src_dir} #{dest_dir}"
  end
  
end #/ namespace ie6nomore