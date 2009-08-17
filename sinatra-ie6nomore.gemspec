# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sinatra-ie6nomore}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["kematzy"]
  s.date = %q{2009-08-18}
  s.email = %q{kematzy@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/sinatra/ie6nomore.i18n.yml",
     "lib/sinatra/ie6nomore.rb",
     "spec/sinatra-ie6nomore_spec.rb",
     "spec/sinatra/ie6nomore_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/kematzy/sinatra-ie6nomore}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{'IE6 No More' Sinatra Extension to make the eradication of IE6 easier}
  s.test_files = [
    "spec/sinatra/ie6nomore_spec.rb",
     "spec/sinatra-ie6nomore_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, [">= 0.9.2"])
      s.add_development_dependency(%q<spec>, [">= 1.2.7"])
      s.add_development_dependency(%q<rspec_hpricot_matchers>, [">= 1.0.0"])
    else
      s.add_dependency(%q<sinatra>, [">= 0.9.2"])
      s.add_dependency(%q<spec>, [">= 1.2.7"])
      s.add_dependency(%q<rspec_hpricot_matchers>, [">= 1.0.0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 0.9.2"])
    s.add_dependency(%q<spec>, [">= 1.2.7"])
    s.add_dependency(%q<rspec_hpricot_matchers>, [">= 1.0.0"])
  end
end
