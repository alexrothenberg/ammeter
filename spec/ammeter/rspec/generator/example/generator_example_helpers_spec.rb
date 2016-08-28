require "spec_helper"

module Ammeter::RSpec::Rails
  describe GeneratorExampleHelpers do
    include GeneratorExampleHelpers
    let(:generator) { MockGenerator.new }

    it "mocks return value of ask to response" do
      set_shell_prompt_responses(generator, { :ask => "response" })
      expect(generator.shell.ask).to eq("response")
    end
    context "arguments contain multiple shell commands" do
      it "mocks return values response for ask and true for yes?" do
        set_shell_prompt_responses(generator, { :ask => "response", :yes? => true })
        expect(generator.shell.ask).to eq("response")
        expect(generator.shell.yes?).to be true
      end
    end
    context "argument shell command contains an array" do
      it "mocks sequential return values response1 and response2" do
        set_shell_prompt_responses(generator, { :ask => ["response1", "response2"] })
        expect(generator.shell.ask).to eq("response1")
        expect(generator.shell.ask).to eq("response2")
      end
    end
  end
end
