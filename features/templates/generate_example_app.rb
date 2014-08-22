rspec_version = ENV['RSPEC_VERSION']
rspec_major_version = (rspec_version && rspec_version != 'master') ? rspec_version.scan(/\d+/).first : '3'

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

gem 'ammeter', :path=>'../..'
if defined?(Rails) && Rails::VERSION::STRING.to_f < 4
  # Execjs is causing problems on 1.8.7
  gem 'execjs', '~> 2.0.0'
end
