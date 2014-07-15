source "http://rubygems.org"

rspec_version = ENV['RSPEC_VERSION']
rspec_major_version = (rspec_version && rspec_version != 'master') ? rspec_version.split('.')[0] : '3'

if rspec_version == 'master'
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

case rspec_major_version
when '2'
  # rspec 2.x does not support Rails 4.1+
  gem 'rails', '~> 3.2'
  gem 'uglifier', '~> 1.2.4'
  gem 'rake', '~> 0.9.2.2'
  gem 'coffee-rails', '~> 3.2'
  gem 'sass-rails', '~> 3.2'
  gem 'jquery-rails', '~> 2.0'
when '3'
  gem 'rails', '>= 4.0'
  gem 'uglifier', '>= 1.3'
  gem 'rake', '>= 0.10'
  gem 'coffee-rails', '>= 4.0'
  gem 'sass-rails', '>= 4.0'
  gem 'jquery-rails', '>= 3.0'
else
  raise "rspec version #{rspec_version} is not supported"
end

# Specify your gem's dependencies in rspec-rails-generator-specs.gemspec
gemspec

