require 'sinatra/base'
require 'yaml'

module Sinatra
  
  # = Sinatra::IE6NoMore Extension
  # 
  # A simple extension in support of the IE6 No More[www.ie6nomore.com] campaign to rid the world of
  # the nasty bug ridden monstrosity called IE6.
  # 
  # Check the IE6 No More[www.ie6nomore.com] site for more information.
  # 
  # === Install
  # 
  # 
  #   sudo gem install kematzy-sinatra-ie6nomore
  # 
  # === Usage 
  # 
  # Three steps
  # 
  # ==== Step 1
  # 
  # Require the Sinatra::IE6NoMore gem
  # 
  #   require 'sinatra/base'
  #   
  #   require 'sinatra/ie6nomore'
  #
  # ==== Step 2
  # 
  # Include in your app.
  # 
  #   class MyApp < Sinatra::Application
  #     
  #     helpers Sinatra::IE6NoMore
  #     
  #     <snip...>
  #     
  #   end
  # 
  # 
  # ==== Step 3
  # 
  # Add this to your <tt>/views/layout.erb</tt> file.
  # 
  #   <html>
  #     <body>
  #       
  #       <%= ie6_no_more %>
  #       
  #     </body>
  #   </html>
  # 
  # And in your HTML you'll see an output like this:
  # 
  #     <!--[if lt IE 7]>
  #     <div style="border: 1px solid #F7941D; background: #FEEFDA; text-align: center; clear: both; height: 75px; position: relative;">
  #      <div style="position: absolute; right: 3px; top: 3px; font-family: courier new; font-weight: bold;"><a href="#" onclick="javascript:this.parentNode.parentNode.style.display="none"; return false;"><img src="http://www.ie6nomore.com/files/theme/ie6nomore-cornerx.jpg" style="border: none;" alt="Close this notice"/></a></div>
  #       <div style="width: 640px; margin: 0 auto; text-align: left; padding: 0; overflow: hidden; color: black;">
  #        <div style="width: 75px; float: left;"><img src="http://www.ie6nomore.com/files/theme/ie6nomore-warning.jpg" alt="Warning!"/></div>
  #        <div style="width: 275px; float: left; font-family: Arial, sans-serif;">
  #        <div style="font-size: 14px; font-weight: bold; margin-top: 12px;">You are using an outdated browser</div>
  #        <div style="font-size: 12px; margin-top: 6px; line-height: 12px;">For a better experience using this site, please upgrade to a modern web browser.</div>
  #       </div>
  #       <div style="width: 75px; float: left;"><a href="http://getfirefox.com/" target="_blank"><img src="http://www.ie6nomore.com/files/theme/ie6nomore-firefox.jpg" style="border: none;" alt="Get Firefox 3.5"/></a></div>
  #       <div style="width: 75px; float: left;"><a href="http://www.browserforthebetter.com/download.html" target="_blank"><img src="http://www.ie6nomore.com/files/theme/ie6nomore-ie8.jpg" style="border: none;" alt="Get Internet Explorer 8"/></a></div>
  #       <div style="width: 73px; float: left;"><a href="http://www.apple.com/safari/download/" target="_blank"><img src="http://www.ie6nomore.com/files/theme/ie6nomore-safari.jpg" style="border: none;" alt="Get Safari 4"/></a></div>
  #       <div style="float: left;"><a href="http://www.google.com/chrome" target="_blank"><img src="http://www.ie6nomore.com/files/theme/ie6nomore-chrome.jpg" style="border: none;" alt="Get Google Chrome"/></a></div>
  #      </div>
  #     </div>
  #     <![endif]-->
  # 
  # 
  # See documentation below for further usage examples.
  # 
  # 
  module IE6NoMore
    
    VERSION = '0.1.1' unless const_defined?(:VERSION)
    def self.version; "Sinatra::IE6NoMore v#{VERSION}"; end
      
    ##
    # Outputs the "IE6 No More" banner.
    # 
    # ==== Params
    # 
    # * options [Hash] => Optional configurations options
    #   * <tt>:locale</tt>   =>  Locale (Default = :en)
    #   * <tt>:img_host</tt>  =>  The URL to the ie6nomore images (Default = http://www.ie6nomore.com/files/theme). <b>NB!</b> No trailing slash
    #   * <tt>:border</tt>  =>  The div border color. (Default = "1px solid #F7941D")
    #   * <tt>:background</tt>  =>  The div background color. (Default = "#FEEFDA")
    #   * <tt>:text_color</tt>  =>  The div text color. (Default = "black")
    #   * <tt>:debug</tt>  =>  Whether to encapsulate the code with the IE Comments or not. (Default = false)
    #  
    # ==== Examples
    # 
    #   ie6_no_more(:locale => :es )   => Spanish version
    # 
    #   ie6_no_more(:img_host => "http://www.example.com/images/ie6") => different image host
    # 
    #   ie6_no_more(:border => "2px dashed green", :background => 'black', :text_color => 'white' ) 
    #     => different color scheme for text, border & background colors
    # 
    # To see how it looks like when developing on a NON-IE 6 browsers.
    # 
    #   ie6_no_more(:debug => true)  => removes the encapsulating IE comments.
    # 
    # @api public
    def ie6_no_more(options = {})
      o = {
        :locale => :en, 
        :img_host => "http://www.ie6nomore.com/files/theme", 
        :border => "1px solid #F7941D", 
        :background => "#FEEFDA", 
        :text_color => "black", 
        :debug => false 
      }.merge(options)
      
      localizations = load_i18n
      # set the localisation 
      i18n = localizations[o[:locale].to_s]
      
      html = '' 
      html << %Q[<!--[if lt IE 7]>\n] unless o[:debug] # == true
      html << %Q[<div style="border: #{o[:border]}; background: #{o[:background]}; text-align: center; clear: both; height: 75px; position: relative;">\n]
      html << %Q[ <div style="position: absolute; right: 3px; top: 3px; font-family: courier new; font-weight: bold;"><a href="#" onclick="javascript:this.parentNode.parentNode.style.display="none"; return false;"><img src="#{o[:img_host]}/ie6nomore-cornerx.jpg" style="border: none;" alt="#{i18n['close']}"/></a></div>\n]
      html << %Q[  <div style="width: 640px; margin: 0 auto; text-align: left; padding: 0; overflow: hidden; color: #{o[:text_color]};">\n]
      html << %Q[   <div style="width: 75px; float: left;"><img src="#{o[:img_host]}/ie6nomore-warning.jpg" alt="Warning!"/></div>\n]
      html << %Q[   <div style="width: 275px; float: left; font-family: Arial, sans-serif;">\n]
      html << %Q[   <div style="font-size: 14px; font-weight: bold; margin-top: 12px;">#{i18n['header']}</div>\n]
      html << %Q[   <div style="font-size: 12px; margin-top: 6px; line-height: 12px;">#{i18n['sub']}</div>\n]
      html << %Q[  </div>\n]
      html << %Q[  <div style="width: 75px; float: left;"><a href="#{i18n['ff_url']}" target="_blank"><img src="#{o[:img_host]}/ie6nomore-firefox.jpg" style="border: none;" alt="#{i18n['get']} Firefox 3.5"/></a></div>\n]
      html << %Q[  <div style="width: 75px; float: left;"><a href="#{i18n['ie_url']}" target="_blank"><img src="#{o[:img_host]}/ie6nomore-ie8.jpg" style="border: none;" alt="#{i18n['get']} Internet Explorer 8"/></a></div>\n]
      html << %Q[  <div style="width: 73px; float: left;"><a href="#{i18n['safari_url']}" target="_blank"><img src="#{o[:img_host]}/ie6nomore-safari.jpg" style="border: none;" alt="#{i18n['get']} Safari 4"/></a></div>\n]
      html << %Q[  <div style="float: left;"><a href="#{i18n['chrome_url']}" target="_blank"><img src="#{o[:img_host]}/ie6nomore-chrome.jpg" style="border: none;" alt="#{i18n['get']} Google Chrome"/></a></div>\n]
      html << %Q[ </div>\n]
      html << %Q[</div>\n]
      html << %Q[<![endif]-->\n] unless o[:debug] # == true
      html
    end
    
    private
      
      ##
      # Loads the i18n.yml localizations file and returns a Hash
      #  
      # ==== Examples
      # 
      #   localizations = load_i18n
      # 
      # @api private
      def load_i18n
        res = YAML.load_file(File.join(File.dirname(__FILE__), 'ie6nomore.i18n.yml'))
      end
      
      
  end #/ IE6NoMore
  
  helpers IE6NoMore
  
end #/ Sinatra