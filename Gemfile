source "http://rubygems.org"

rspec_version = ENV['RSPEC_VERSION'] || '2.99.0.beta2'

case rspec_version
when 'master'
  gem "rspec-rails", :git => 'git://github.com/rspec/rspec-rails.git'
  gem "rspec", :git => 'git://github.com/rspec/rspec.git'
  gem "rspec-core", :git => 'git://github.com/rspec/rspec-core.git'
  gem "rspec-expectations", :git => 'git://github.com/rspec/rspec-expectations.git'
  gem "rspec-mocks", :git => 'git://github.com/rspec/rspec-mocks.git'
  gem "rspec-collection_matchers", :git => 'git://github.com/rspec/rspec-collection_matchers.git'
  gem "rspec-support", :git => 'git://github.com/rspec/rspec-support.git'
else
  gem 'rspec-rails', rspec_version
  gem 'rspec',       rspec_version
end

# Specify your gem's dependencies in rspec-rails-generator-specs.gemspec
gemspec

