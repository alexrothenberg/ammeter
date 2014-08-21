require 'rspec/core'
if RSpec::Core::Version::STRING < '3'
  require 'ammeter/rspec/rspec_2_compatibility'  # if rspec2
end
require 'rails'
require 'ammeter/output_capturer.rb'
require 'ammeter/rspec/generator/example.rb'
require 'ammeter/rspec/generator/matchers.rb'

if Rails.respond_to?(:application) && Rails.application.respond_to?(:load_generators)
  Rails.application.load_generators
end
