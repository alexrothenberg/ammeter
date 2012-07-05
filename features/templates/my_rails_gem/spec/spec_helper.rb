require 'bundler/setup'
require 'rails/all'

module MyRailsGem
  module TestApp
    class Application < Rails::Application
      config.root = File.dirname(__FILE__)
    end
  end
end

require 'ammeter/init'

Bundler.require
