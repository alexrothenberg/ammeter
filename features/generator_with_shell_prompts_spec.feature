@example_app
Feature: generator with shell prompts spec

  Generator specs live in spec/generators. In order to access
  the generator's methods you can call them on the "generator" object.

  Background: A simple generator
    Given a file named "lib/generators/awesome/lamest_generator.rb" with:
      """
      class LamestGenerator < Rails::Generators::NamedBase
        source_root File.expand_path('../templates', __FILE__)
        class_option :super, :type => :boolean, :default => false

        def create_lamest
          @lame = false 
          @awesome = false
          @user_name = ask("What is your name?")
          if yes?("Are you the lamest?")
            @lame = true
          end
          if yes?("Are you awesome?")
            @awesome = true
          end
          template 'lamest.html.erb', File.join('public', name, "#{"super_" if options[:super]}lamest.html")
        end
      end
      """
    And a file named "lib/generators/awesome/templates/lamest.html.erb" with:
      """
      <%= @user_name %> <%= "is the lamest" if @lame %> and <%= "is not awesome!" if @awesome == false %>
      """

  Scenario: A spec that runs the entire generator
    Given a file named "spec/generators/lamest_generator_spec.rb" with:
      """
      require "rails_helper"
      require 'generators/awesome/lamest_generator'

      describe LamestGenerator do
        describe 'invoke' do
          before do 
            gen = generator %w(my_dir)
            set_shell_prompt_responses(gen, { :ask => "Thomas", :yes? => [true, false] })
            run_generator
          end
          describe 'public/my_dir/lamest.html' do
            subject { file('public/my_dir/lamest.html') }
            it { expect(subject).to exist }
            it { expect(subject).to contain 'Thomas is the lamest and is not awesome!' }
            it { expect(subject).to_not contain 'This text is not in the file' }
          end
        end
      end
      """
    When I run `rake spec`
    Then the output should contain "3 examples, 0 failures"
