require "#{File.dirname(File.dirname(File.expand_path(__FILE__)))}/spec_helper"

describe "Sinatra" do 
  
  def remove_enclosing_html_comments(markup)
    return markup.sub('<!--[if lt IE 7]>', '').sub('<![endif]-->','')
  end
  
  describe "IE6NoMore" do 
    
    class MyTestApp
      register(Sinatra::IE6NoMore)
    end
    
    # convenience shared spec that sets up MyTestApp and tests it's OK,
    # without it you will get "stack level too deep" errors
    it_should_behave_like "MyTestApp"
    
    describe "#self.gem_root_path" do 
      
      it "should return the full path to the gem" do 
        Sinatra::IE6NoMore.gem_root_path.should == File.expand_path(File.join(File.dirname(__FILE__), '..','..'))
      end
      
    end #/ #self.gem_root_path
    
    describe "#ie6_no_more" do 
      
      describe "with defaults" do 
        
        it "should return the expected HTML" do 
          erb_app %Q[<%= ie6_no_more %>]
          
          # test the comments first before removing
          body.should match(/<!--\[if lt IE 7\]/)
          body.should match(/<!\[endif\]-->$/)
          
          # remove the comments so we can test the code output
          markup = remove_enclosing_html_comments(body)
          # we get the border and background through OK
          markup.should match(/<div id="ie6nomore" style="border: 1px solid #F7941D; background: #FEEFDA;/)
          # we have a warning image
          markup.should have_tag('div[@style=width: 75px; float: left;] > img') do |img|
            img.attributes['src'].should == '/images/ie6nomore/ie6nomore-warning.jpg'
          end
          markup.should have_tag('img[@src=/images/ie6nomore/ie6nomore-cornerx.jpg]')
          # text
          markup.should have_tag('img[@alt=Close this notice]')
          markup.should have_tag('div[@style=font-size: 14px; font-weight: bold; margin-top: 12px;]','You are using an outdated browser')
          markup.should have_tag('div[@style=font-size: 12px; margin-top: 6px; line-height: 12px;]','For a better experience using this site, please upgrade to a modern web browser.')
          # browsers
          markup.should have_tag('div > a[@href=http://getfirefox.com/] > img') do |img|
            img.attributes['src'].should == '/images/ie6nomore/ie6nomore-firefox.jpg'
            img.attributes['alt'].should == 'Get Firefox 3.5'
          end
          markup.should have_tag('div > a[@href=http://www.browserforthebetter.com/download.html] > img') do |img|
            img.attributes['src'].should == '/images/ie6nomore/ie6nomore-ie8.jpg'
            img.attributes['alt'].should == 'Get Internet Explorer 8'
          end
          markup.should have_tag('div > a[@href=http://www.apple.com/safari/download/] > img') do |img|
            img.attributes['src'].should == '/images/ie6nomore/ie6nomore-safari.jpg'
            img.attributes['alt'].should == 'Get Safari 4'
          end
          markup.should have_tag('div > a[@href=http://www.google.com/chrome] > img') do |img|
            img.attributes['src'].should == '/images/ie6nomore/ie6nomore-chrome.jpg'
            img.attributes['alt'].should == 'Get Google Chrome'
          end
        end
        
      end #/ with defaults
      
      describe "with options" do 
        
        before(:each) do 
          erb_app %Q[<%= ie6_no_more(:img_host => "http://example.com/images/", :background => 'yellow', :border => '10px dashed #fff', :text_color => 'red' ) %>]
          # remove the comments so we can test the code output
          @markup = remove_enclosing_html_comments(last_response.body)
        end
        
        it "should set the border style attribute" do 
          @markup.should match(/<div id="ie6nomore" style="border: 10px dashed #fff; background: yellow;/)
        end
        
        it "should set the background style attribute" do 
          @markup.should match(/<div id="ie6nomore" style="(.*)background: yellow;/)
        end
        
        it "should set the text color style attribute" do 
          @markup.should match(/<div style="(.*)color: red;/)
        end
        
        it "should set the image src attributes to the value given by img_host" do 
          @markup.should have_tag('img[@src=http://example.com/images/ie6nomore-cornerx.jpg]')
        end
        
        it "should show the HTML without IE comments when :debug => true " do 
          erb_app %Q[<%= ie6_no_more(:debug => true ) %>]
          markup = last_response.body
          body.should_not match(/<!--\[if lt IE 7\]/)
          body.should_not match(/<!\[endif\]-->$/)
        end
        
      end #/ with options
      
      describe "with localizations" do 
        
        it "should have Spanish version" do 
          erb_app %Q[<%= ie6_no_more(:locale => :es ) %>]
          # remove the comments so we can test the code output
          markup = remove_enclosing_html_comments(last_response.body)
          
          # text
          markup.should have_tag('img[@alt=Cierra este aviso]')
          markup.should have_tag('div[@style=font-size: 14px; font-weight: bold; margin-top: 12px;]','Usted está usando un navegador obsoleto.')
          markup.should have_tag('div[@style=font-size: 12px; margin-top: 6px; line-height: 12px;]','Para navegar mejor por este sitio, por favor, actualice su navegador.')
          
          # browsers
          markup.should have_tag('div > a[@href=http://www.mozilla-europe.org/es/firefox/] > img') do |img|
            img.attributes['alt'].should == 'Consiga Firefox 3.5'
          end
          markup.should have_tag('div > a[@href=http://www.microsoft.com/downloads/details.aspx?FamilyID=341c2ad5-8c3d-4347-8c03-08cdecd8852b&DisplayLang=es] > img') do |img|
            img.attributes['alt'].should == 'Consiga Internet Explorer 8'
          end
          markup.should have_tag('div > a[@href=http://www.apple.com/es/safari/download/] > img') do |img|
            img.attributes['alt'].should == 'Consiga Safari 4'
          end
          markup.should have_tag('div > a[@href=http://www.google.com/chrome?hl=es] > img') do |img|
            img.attributes['alt'].should == 'Consiga Google Chrome'
          end
        end
        
        it "should have French version" do 
          erb_app %Q[<%= ie6_no_more(:locale => :fr ) %>]
          # remove the comments so we can test the code output
          markup = remove_enclosing_html_comments(last_response.body)
          
          # text
          markup.should have_tag('img[@alt=Fermez cette notification]')
          markup.should have_tag('div[@style=font-size: 14px; font-weight: bold; margin-top: 12px;]','Vous utilisez un navigateur dépassé depuis près de 8 ans!')
          markup.should have_tag('div[@style=font-size: 12px; margin-top: 6px; line-height: 12px;]','Pour une meilleure expérience web, prenez le temps de mettre votre navigateur à jour.')
          
          # browsers
          markup.should have_tag('div > a[@href=http://fr.www.mozilla.com/fr/] > img') do |img|
            img.attributes['alt'].should == 'Obtenez Firefox 3.5'
          end
          markup.should have_tag('div > a[@href=http://www.microsoft.com/downloads/details.aspx?FamilyID=341c2ad5-8c3d-4347-8c03-08cdecd8852b&DisplayLang=fr] > img') do |img|
            img.attributes['alt'].should == 'Obtenez Internet Explorer 8'
          end
          markup.should have_tag('div > a[@href=http://www.apple.com/fr/safari/download/] > img') do |img|
            img.attributes['alt'].should == 'Obtenez Safari 4'
          end
          markup.should have_tag('div > a[@href=http://www.google.com/chrome?hl=fr] > img') do |img|
            img.attributes['alt'].should == 'Obtenez Google Chrome'
          end
        end
        
        it "should have Portugese version" do 
          erb_app %Q[<%= ie6_no_more(:locale => :br ) %>]
          # remove the comments so we can test the code output
          markup = remove_enclosing_html_comments(last_response.body)
          # markup.should have_tag('debug')
          
          # text
          markup.should have_tag('img[@alt=Feche esta observação]')
          markup.should have_tag('div[@style=font-size: 14px; font-weight: bold; margin-top: 12px;]','Você está usando um navegador desatualizado')
          markup.should have_tag('div[@style=font-size: 12px; margin-top: 6px; line-height: 12px;]','Para navegar melhor neste site, por favor, atualize seu navegador.')
          
          # browsers
          markup.should have_tag('div > a[@href=http://pt-br.www.mozilla.com/pt-BR/] > img') do |img|
            img.attributes['alt'].should == 'Obtenha Firefox 3.5'
          end
          markup.should have_tag('div > a[@href=http://www.microsoft.com/downloads/details.aspx?FamilyID=341c2ad5-8c3d-4347-8c03-08cdecd8852b&DisplayLang=pt-br] > img') do |img|
            img.attributes['alt'].should == 'Obtenha Internet Explorer 8'
          end
          markup.should have_tag('div > a[@href=http://www.apple.com/br/safari/download/] > img') do |img|
            img.attributes['alt'].should == 'Obtenha Safari 4'
          end
          markup.should have_tag('div > a[@href=http://www.google.com/chrome?hl=pt-BR] > img') do |img|
            img.attributes['alt'].should == 'Obtenha Google Chrome'
          end
        end
        
        it "should have Italian version" do 
          erb_app %Q[<%= ie6_no_more(:locale => :it ) %>]
          # remove the comments so we can test the code output
          markup = remove_enclosing_html_comments(last_response.body)
          # markup.should have_tag('debug')
          
          # text
          markup.should have_tag('img[@alt=Chiuda questo avviso]')
          markup.should have_tag('div[@style=font-size: 14px; font-weight: bold; margin-top: 12px;]','Stai usando un browser obsoleto')
          markup.should have_tag('div[@style=font-size: 12px; margin-top: 6px; line-height: 12px;]','Per una migliore navigazione su questo sito, per cortesia passa ad un browser di ultima generazione.')
          
          # browsers
          markup.should have_tag('div > a[@href=http://www.mozilla-europe.org/it/] > img') do |img|
            img.attributes['alt'].should == 'Ottenga Firefox 3.5'
          end
          markup.should have_tag('div > a[@href=http://www.microsoft.com/downloads/details.aspx?FamilyID=341c2ad5-8c3d-4347-8c03-08cdecd8852b&DisplayLang=it] > img') do |img|
            img.attributes['alt'].should == 'Ottenga Internet Explorer 8'
          end
          markup.should have_tag('div > a[@href=http://www.apple.com/it/safari/download/] > img') do |img|
            img.attributes['alt'].should == 'Ottenga Safari 4'
          end
          markup.should have_tag('div > a[@href=http://www.google.com/chrome?hl=it] > img') do |img|
            img.attributes['alt'].should == 'Ottenga Google Chrome'
          end
        end
        
        it "should have Japanese version" do 
          erb_app %Q[<%= ie6_no_more(:locale => :jp ) %>]
          # remove the comments so we can test the code output
          markup = remove_enclosing_html_comments(last_response.body)
          # markup.should have_tag('debug')
          
          # text
          markup.should have_tag('img[@alt=この注意を閉じなさい]')
          markup.should have_tag('div[@style=font-size: 14px; font-weight: bold; margin-top: 12px;]','>あなたは旧式ブラウザをご利用中です')
          markup.should have_tag('div[@style=font-size: 12px; margin-top: 6px; line-height: 12px;]','このウェブサイトを快適に閲覧するにはブラウザをアップグレードしてください。')
          
          # browsers
          markup.should have_tag('div > a[@href=http://www.mozilla.jp/] > img') do |img|
            img.attributes['alt'].should == 'Get Firefox 3.5'
          end
          markup.should have_tag('div > a[@href=http://www.microsoft.com/downloads/details.aspx?FamilyID=341c2ad5-8c3d-4347-8c03-08cdecd8852b&DisplayLang=ja] > img') do |img|
            img.attributes['alt'].should == 'Get Internet Explorer 8'
          end
          markup.should have_tag('div > a[@href=http://www.apple.com/jp/safari/download/] > img') do |img|
            img.attributes['alt'].should == 'Get Safari 4'
          end
          markup.should have_tag('div > a[@href=http://www.google.com/chrome?hl=ja] > img') do |img|
            img.attributes['alt'].should == 'Get Google Chrome'
          end
        end
        
        it "should have Swedish version" do 
          erb_app %Q[<%= ie6_no_more(:locale => :se ) %>]
          # remove the comments so we can test the code output
          markup = remove_enclosing_html_comments(last_response.body)
          # markup.should have_tag('debug')
          
          # text
          markup.should have_tag('img[@alt=Stäng denna notering]')
          markup.should have_tag('div[@style=font-size: 14px; font-weight: bold; margin-top: 12px;]','Du använder en föråldrad webbläsare')
          markup.should have_tag('div[@style=font-size: 12px; margin-top: 6px; line-height: 12px;]','För en bättre upplevelse på denna webbplats, vänligen byt till en modern webbläsare.')
          
          # browsers
          markup.should have_tag('div > a[@href=http://sv-se.www.mozilla.com/sv-SE/] > img') do |img|
            img.attributes['alt'].should == 'Ladda ner Firefox 3.5'
          end
          markup.should have_tag('div > a[@href=http://www.microsoft.com/downloads/details.aspx?FamilyID=341c2ad5-8c3d-4347-8c03-08cdecd8852b&DisplayLang=sv-SE] > img') do |img|
            img.attributes['alt'].should == 'Ladda ner Internet Explorer 8'
          end
          markup.should have_tag('div > a[@href=http://www.apple.com/se/safari/download/] > img') do |img|
            img.attributes['alt'].should == 'Ladda ner Safari 4'
          end
          markup.should have_tag('div > a[@href=http://www.google.com/chrome?hl=sv-SE] > img') do |img|
            img.attributes['alt'].should == 'Ladda ner Google Chrome'
          end
        end
        
        it "should have further localizations" do 
          pending "awaiting translations from www.ie6nomore.com"
        end
        
      end #/ with localizations
      
    end #/ ie6_no_more
    
    describe "#load_i18n" do 
      
      module Sinatra::IE6NoMore::Helpers 
        public :load_i18n
      end
      
      it "should return a Hash" do 
        app.load_i18n.should be_a_kind_of(Hash)
      end
      
      it "should have further tests" do 
        pending "energy and time to fix this...."
      end
      
    end #/ #load_i18n
    
    describe "Rake Tasks" do 
      
      describe "rake ie6nomore:copy_images" do 
        
        it "should copy the images from the gem root to the app/public/images/ie6nomore directory" do 
          pending "TODO: need to work out how to test this functionality"
        end
        
      end #/ rake ie6nomore:copy_images
      
    end #/ Rake Tasks
    
  end #/ IE6NoMore
  
end #/ Sinatra
