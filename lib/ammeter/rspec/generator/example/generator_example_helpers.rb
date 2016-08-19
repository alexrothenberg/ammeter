require 'rails/generators'
require 'active_support/core_ext'

module Ammeter
  module RSpec
    module Rails
      # Delegates to Rails::Generators::TestCase to work with RSpec.
      module GeneratorExampleHelpers

        # Sets return values for basic shell commands (ex. ask, yes?, no?). 
        # Does this by mocking return values using RSpec's `and_return` method
        # 
        # ===== Parameters =====
        # Generator w/ @shell attribute
        # Hash { command_name: input_value, ask: "Testing", yes?: true }
        # The values for each element in the hash can be set as an array as well.
        # This will allow for different return values upon each call.
        # 
        # ex. set_shell_prompt_responses(generator, { yes?: [true, false] })
        # would respond with true to the first yes? call, but false to the second
        def set_shell_prompt_responses(generator, command_args={})
          command_args.each do |k,v|
            allow(generator.shell).to receive(k.to_sym).and_return(*v)
          end
        end
      end
    end
  end
end
