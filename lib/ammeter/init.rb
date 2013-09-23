require 'rails'
require 'ammeter/rspec/generator/example.rb'
require 'ammeter/rspec/generator/matchers.rb'

if Rails.respond_to?(:application) && Rails.application.respond_to?(:load_generators)
  Rails.application.load_generators
end
