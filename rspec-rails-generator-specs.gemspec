# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rspec-rails-generator-specs/version"

Gem::Specification.new do |s|
  s.name        = "rspec-rails-generator-specs"
  s.version     = Rspec::Rails::Generator::Specs::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alex Rothenberg"]
  s.email       = ["alex@alexrothenberg.com"]
  s.homepage    = ""
  s.summary     = %q{Write specs for your Rails 3 generators}
  s.description = %q{Write specs for your Rails 3 generators}

  s.rubyforge_project = "rspec-rails-generator-specs"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
