require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "sinatra-ie6nomore"
    gem.summary = %Q{A Sinatra Extension that shows an 'IE6 No More' div on the page for IE6 browsers, making the eradication of IE6 easier.}
    gem.description = %Q{A Sinatra Extension that shows an 'IE6 No More' div on the page for IE6 browsers, making the eradication of IE6 easier.}
    gem.email = "kematzy@gmail.com"
    gem.homepage = "http://github.com/kematzy/sinatra-ie6nomore"
    gem.authors = ["kematzy"]
    gem.add_dependency('sinatra', '>= 0.9.4')
    gem.add_development_dependency('spec', '>= 1.2.7')
    gem.add_development_dependency('rspec_hpricot_matchers', '>= 1.0.0')
    
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_opts = ["--color", "--format", "specdoc", "--require", "spec/spec_helper.rb"]  
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_opts = ["--color", "--format", "specdoc", "--require", "spec/spec_helper.rb"]  
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end


namespace :spec do
  
  desc "Run all specifications quietly"
  Spec::Rake::SpecTask.new(:quiet) do |t|
    t.libs << "lib"
    t.spec_opts = ["--color", "--require", "spec/spec_helper.rb"]
  end
  
  desc "Run specific spec verbosely (SPEC=/path/2/file)"
  Spec::Rake::SpecTask.new(:select) do |t|
    t.libs << "lib"
    t.spec_files = [ENV["SPEC"]]
    t.spec_opts = ["--color", "--format", "specdoc", "--require", "spec/spec_helper.rb"] 
  end
  
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? IO.read('VERSION').chomp : "[Unknown]" 

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "Sinatra::IE6NoMore v#{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Build the rdoc HTML Files'
task :docs do
  version = File.exist?('VERSION') ? IO.read('VERSION').chomp : "[Unknown]" 
  
  sh "sdoc -N --title 'Sinatra::IE6NoMore v#{version}' lib/sinatra README.rdoc"
end


namespace :docs do
  
  desc 'Remove rdoc products'
  task :remove => [:clobber_rdoc]
  
  desc 'Force a rebuild of the RDOC files'
  task :rebuild => [:rerdoc]
  
  desc 'Build docs, and open in browser for viewing (specify BROWSER)'
  task :open => [:docs] do
    browser = ENV["BROWSER"] || "safari"
    sh "open -a #{browser} doc/index.html"
  end
  
end
