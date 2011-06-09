require 'rails/all'
require 'rspec/rails'
require 'ammeter'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

# TODO - most of this is borrowed from rspec-rails's spec_helper - which 
# is copied from rspec-core's
module MatchesForRSpecRailsSpecs
  extend RSpec::Matchers::DSL

  matcher :be_included_in_files_in do |path|
    match do |mod|
      stub_metadata(
        :example_group => {:file_path => "#{path}whatever_spec.rb:15"}
      )
      group = RSpec::Core::ExampleGroup.describe
      group.included_modules.include?(mod)
    end
  end
end

RSpec.configure do |c|
  c.include MatchesForRSpecRailsSpecs
end
