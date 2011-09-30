require 'rspec/core'
require 'ammeter/rspec/generator/example/generator_example_group'

RSpec::configure do |c|
  c.include Ammeter::RSpec::Rails::GeneratorExampleGroup, :type => :generator, :example_group => {
    :file_path => /spec[\\\/]generators/
  }
end
