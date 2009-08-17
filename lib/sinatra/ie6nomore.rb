require 'sinatra/base'
require 'yaml'

module Sinatra

  # Sinatra IE6NoMore module
  # 
  #  TODO:: Need to write documentation here 
  # 
  module IE6NoMore
    
    VERSION = '0.1.0' unless const_defined?(:VERSION)
    def self.version; "Sinatra::IE6NoMore v#{VERSION}"; end
    
    
    module Helpers
      
      ##
      # TODO: add some comments here
      #  
      # ==== Examples
      # 
      # 
      # @api public
      def ie6_no_more(options = {})
        o = {
          :locale => :en, 
          :img_host => "http://www.ie6nomore.com/files/theme", 
          :border => "1px solid #F7941D", 
          :background => "#FEEFDA", 
          :text => "black", 
        }.merge(options)
        
        localizations = load_i18n
        # set the localisation 
        i18n = localizations[o[:locale]]
        
        html = %Q[<!--[if lt IE 7]>\n]
        html << %Q[<div style="border: #{o[:border]}; background: #{o[:background]}; text-align: center; clear: both; height: 75px; position: relative;">\n]
        html << %Q[ <div style="position: absolute; right: 3px; top: 3px; font-family: courier new; font-weight: bold;"><a href="#" onclick="javascript:this.parentNode.parentNode.style.display="none"; return false;"><img src="#{o[:img_host]}/ie6nomore-cornerx.jpg" style="border: none;" alt="#{i18n['close']}"/></a></div>\n]
        html << %Q[  <div style="width: 640px; margin: 0 auto; text-align: left; padding: 0; overflow: hidden; color: #{o[:text]};">\n]
        html << %Q[   <div style="width: 75px; float: left;"><img src="#{o[:img_host]}/ie6nomore-warning.jpg" alt="Warning!"/></div>\n]
        html << %Q[   <div style="width: 275px; float: left; font-family: Arial, sans-serif;">\n]
        html << %Q[   <div style="font-size: 14px; font-weight: bold; margin-top: 12px;">#{i18n['header']}</div>\n]
        html << %Q[   <div style="font-size: 12px; margin-top: 6px; line-height: 12px;">#{i18n['sub']}</div>\n]
        html << %Q[  </div>\n]
        html << %Q[  <div style="width: 75px; float: left;"><a href="#{i18n['ff_url']}" target="_blank"><img src="#{o[:img_host]}/ie6nomore-firefox.jpg" style="border: none;" alt="Get Firefox 3.5"/></a></div>\n]
        html << %Q[  <div style="width: 75px; float: left;"><a href="#{i18n['ie_url']}" target="_blank"><img src="#{o[:img_host]}/ie6nomore-ie8.jpg" style="border: none;" alt="Get Internet Explorer 8"/></a></div>\n]
        html << %Q[  <div style="width: 73px; float: left;"><a href="#{i18n['safari_url']}" target="_blank"><img src="#{o[:img_host]}/ie6nomore-safari.jpg" style="border: none;" alt="Get Safari 4"/></a></div>\n]
        html << %Q[  <div style="float: left;"><a href="#{i18n['chrome_url']}" target="_blank"><img src="#{o[:img_host]}/ie6nomore-chrome.jpg" style="border: none;" alt="Get Google Chrome"/></a></div>\n]
        html << %Q[ </div>\n]
        html << %Q[</div>\n<![endif]-->\n]
        html
      end
      
      ## PRIVATE METHODS
      private
        
        
        ##
        # TODO: add some comments here
        #  
        # ==== Examples
        # 
        # 
        # @api private
        def load_i18n
          res = YAML.load_file(File.join(File.dirname(__FILE__), 'ie6nomore.i18n.yml'))
        end
      
    end #/ Helpers
    
    # def self.registered(app)
    #   app.helpers IE6NoMore::Helpers
    #   
    # end #/ self.registered
    
  end #/ IE6NoMore
  
end #/ Sinatra