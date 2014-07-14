require 'rails/all'
require 'rspec/rails'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

module TestApp
  class Application < Rails::Application
    config.root = File.dirname(__FILE__)
  end
end

require 'ammeter/init'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |c|
  c.include MatchesForRSpecRailsSpecs
  if RSpec::Core::Version::STRING < '3'
    c.include RSpec2MemoizedHelpersCompatibility
  end
end
