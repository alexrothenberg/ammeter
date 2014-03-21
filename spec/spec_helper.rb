require 'rails/all'
require 'rspec/rails'

module TestApp
  class Application < Rails::Application
    config.root = File.dirname(__FILE__)
  end
end

require 'ammeter/init'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |c|
  c.include MatchesForRSpecRailsSpecs
end
