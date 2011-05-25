# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rails-generator-spec/version"

Gem::Specification.new do |s|
  s.name        = "rails-generator-spec"
  s.version     = Rails::Generator::Spec::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alex Rothenberg"]
  s.email       = ["alex@alexrothenberg.com"]
  s.homepage    = ""
  s.summary     = %q{Write specs for your Rails 3 generators}
  s.description = %q{Write specs for your Rails 3 generators}

  s.rubyforge_project = "rails-generator-spec"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency 'railties',    '~> 3.0'
  s.add_runtime_dependency 'rspec',       '~> 2.6'
  s.add_runtime_dependency 'rspec-rails', '~> 2.6'

  s.add_development_dependency 'rails',    '~> 3.0'
  s.add_development_dependency 'rake',     '= 0.8.7'
  s.add_development_dependency 'cucumber', '~> 0.10.2'
  s.add_development_dependency 'aruba',    '~> 0.3.5'
  
end
