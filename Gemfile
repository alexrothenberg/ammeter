source "http://rubygems.org"

rspec_version = 2.14

case rspec_version
when '3'
  gem "rspec-rails", :git => 'git://github.com/rspec/rspec-rails.git'
  gem "rspec", :git => 'git://github.com/rspec/rspec.git'
  gem "rspec-core", :git => 'git://github.com/rspec/rspec-core.git'
  gem "rspec-expectations", :git => 'git://github.com/rspec/rspec-expectations.git'
  gem "rspec-mocks", :git => 'git://github.com/rspec/rspec-mocks.git'
  gem "rspec-collection_matchers", :git => 'git://github.com/rspec/rspec-collection_matchers.git'
  gem "rspec-support", :git => 'git://github.com/rspec/rspec-support.git'
when '2.99'
  gem 'rspec-rails', '2.99.0.beta2'
when '2.14'
  gem 'rspec-rails', '2.14.2'
end

# Specify your gem's dependencies in rspec-rails-generator-specs.gemspec
gemspec

