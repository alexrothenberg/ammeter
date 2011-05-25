require 'rails-generator-spec/rspec/generator/example/generator_example_group'

RSpec::configure do |c|
  c.include RSpec::Rails::GeneratorExampleGroup, :type => :generator, :example_group => {
    :file_path => c.escaped_path(%w[spec generators])
  }
end
