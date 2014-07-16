# -*- encoding: utf-8 -*-
require File.expand_path('../lib/my_rails_gem/version', __FILE__)

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

  gem.add_runtime_dependency     'rails', '>= 3.2'
end
