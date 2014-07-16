require 'bundler/setup'
require 'rails/all'
# This prevents 'uninitialized constant Jquery::Rails::Railtie::PROTOTYPE_JS (NameError)'
require 'jquery/rails'

module MyRailsGem
  module TestApp
    class Application < Rails::Application
      config.root = File.dirname(__FILE__)
    end
  end
end

require 'ammeter/init'

Bundler.require
