# -*- encoding: utf-8 -*-
require File.expand_path('../lib/my_rails_gem/version', __FILE__)

rspec_version = ENV['RSPEC_VERSION']
rspec_major_version = (rspec_version && rspec_version != 'master') ? rspec_version.split('.')[0] : '3'

Gem::Specification.new do |gem|
  gem.authors       = ["Alex Rothenberg"]
  gem.email         = ["alex@alexrothenberg.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "my_rails_gem"
  gem.require_paths = ["lib"]
  gem.version       = MyRailsGem::VERSION

  case rspec_major_version
  when '2'
    gem.add_runtime_dependency     'rails', '~> 3.2'
  when '3'
    gem.add_runtime_dependency     'rails', '>= 4.1'
  else
    raise "rspec version #{rspec_version} is not supported"
  end
end
