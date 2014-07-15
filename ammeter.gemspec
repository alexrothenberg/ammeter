# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ammeter/version"

rspec_version = ENV['RSPEC_VERSION']
rspec_major_version = (rspec_version && rspec_version != 'master') ? rspec_version.split('.')[0] : '3'

Gem::Specification.new do |s|
  s.name        = "ammeter"
  s.version     = Ammeter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alex Rothenberg"]
  s.email       = ["alex@alexrothenberg.com"]
  s.homepage    = ""
  s.summary     = %q{Write specs for your Rails 3+ generators}
  s.description = %q{Write specs for your Rails 3+ generators}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'railties',      '>= 3.0'
  s.add_runtime_dependency 'activesupport', '>= 3.0'
  s.add_runtime_dependency 'rspec-rails',   '>= 2.2'

  case rspec_major_version
  when '2'
    # rspec 2.x does not support Rails 4.1+
    s.add_development_dependency 'rails',        '~> 3.2'
    s.add_development_dependency 'uglifier',     '~> 1.2.4'
    s.add_development_dependency 'rake',         '~> 0.9.2.2'
    s.add_development_dependency 'coffee-rails', '~> 3.2'
    s.add_development_dependency 'sass-rails',   '~> 3.2'
    s.add_development_dependency 'jquery-rails', '~> 2.0'
  when '3'
    s.add_development_dependency 'rails',        '>= 4.0'
    s.add_development_dependency 'uglifier',     '>= 1.3'
    s.add_development_dependency 'rake',         '>= 0.10'
    s.add_development_dependency 'coffee-rails', '>= 4.0'
    s.add_development_dependency 'sass-rails',   '>= 4.0'
    s.add_development_dependency 'jquery-rails', '>= 3.0'
  else
    raise "rspec version #{rspec_version} is not supported"
  end

  s.add_development_dependency 'rspec',        '>= 2.2'
  s.add_development_dependency 'cucumber',     '>= 0.10'
  s.add_development_dependency 'aruba',        '>= 0.3'

  case RUBY_PLATFORM
  when 'java'
    s.add_development_dependency 'activerecord-jdbcsqlite3-adapter'
    s.add_development_dependency 'therubyrhino'
  else
    s.add_development_dependency 'sqlite3',      '>= 1'
  end
end
