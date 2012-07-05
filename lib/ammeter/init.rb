require 'ammeter/rspec/generator/example.rb'
require 'ammeter/rspec/generator/matchers.rb'
require 'rails'

if Rails.application.nil?
  # We are in a gem so create test Rails app
  module Ammeter
    module TestApp
      class Application < Rails::Application
        config.root = File.dirname(__FILE__)
      end
    end
  end
end

Rails.application.load_generators
