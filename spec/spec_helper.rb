require 'rubygems'
require 'spec'
require 'spec/interop/test'
require 'rack/test'
require 'rspec_hpricot_matchers'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'sinatra/ie6nomore'

Spec::Runner.configure do |config|
  config.include RspecHpricotMatchers
end

class MyTestApp < Sinatra::Base 
  
  helpers Sinatra::IE6NoMore
  
  get '/tests' do
    case params[:engine]
    when 'erb'
      erb(params[:view], :layout => params[:layout] )
    when 'haml'
      haml(params[:view], :layout => params[:layout] )
    else
      params.inspect
    end
  end
  
end #/class MyTestApp



class Test::Unit::TestCase
  include Rack::Test::Methods
  
  def setup
    Sinatra::Base.set :environment, :test
  end
  
  def app
    MyTestApp.new
  end
  
  def erb_app(view, options = {})
    options = {:layout => '<%= yield %>', :url  => '/tests' }.merge(options)
    get options[:url], :view => view, :layout => options[:layout], :engine => :erb 
  end
  
end
