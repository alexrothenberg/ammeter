# Used in generator_example_helpers_spec.rb
# set_shell_prompt_responses requires a generator w/ a shell
# as an argument. This class defines that generator w/ a shell.
require_relative 'mock_shell'

class Generator
  attr_accessor :shell

  def initialize
    @shell = Shell.new
  end
end
