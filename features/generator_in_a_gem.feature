Feature: Gems can contain generators

  Within a Gem Rails may often not be loaded (but railties is)
  We should still be able to write a spec for these generators

  @railties_gem
  Scenario: A generator with "railties" dependency
    Given a file named "lib/generators/awesome/awesome_generator.rb" with:
      """
      class AwesomeGenerator < Rails::Generators::NamedBase
        source_root File.expand_path('../templates', __FILE__)
        class_option :super, :type => :boolean, :default => false

        def create_awesomeness
          template 'awesome.html', File.join('public', name, "#{"super_" if options[:super]}awesome.html")
        end
      end
      """
    And a file named "lib/generators/awesome/templates/awesome.html" with:
      """
      This is an awesome file
      """
    And a file named "spec/generators/awesome_generator_spec.rb" with:
      """
      require "spec_helper"
      require 'generators/awesome/awesome_generator'

      describe AwesomeGenerator do
        before { run_generator %w(my_dir) }
        describe 'public/my_dir/awesome.html' do
          subject { file('public/my_dir/awesome.html') }
          it { expect(subject).to exist }
          it { expect(subject).to contain 'This is an awesome file' }
          it { expect(subject).to_not contain 'This text is not in the file' }
        end
      end
      """
    When I run `rake spec`
    Then the output should contain "3 examples, 0 failures"

  @rails_gem
  Scenario: A generator that uses "hook_for"
    Given a file named "lib/generators/resourceful/resourceful_generator.rb" with:
      """
      class ResourcefulGenerator < Rails::Generators::NamedBase
        source_root File.expand_path('../templates', __FILE__)
        class_option :super, :type => :boolean, :default => false

        hook_for :orm, :in => :rails, :as => :model, :required => true

        def create_resourceful_controller
          template 'controller.rb', File.join('app/controllers',  "#{plural_file_name}_controller.rb")
        end
      end
      """
    And a file named "lib/generators/resourceful/templates/controller.rb" with:
      """
      class <%= class_name.pluralize %>Controller < ResourcefulController
      end
      """
    And a file named "spec/generators/resourceful_generator_spec.rb" with:
      """
      require "spec_helper"
      require 'generators/resourceful/resourceful_generator'

      describe ResourcefulGenerator do
        before { run_generator %w(post) }
        describe 'app/controller/posts_controller.rb' do
          subject { file('app/controllers/posts_controller.rb') }
          it { expect(subject).to exist }
          it { expect(subject).to contain 'class PostsController < ResourcefulController' }
        end

        describe 'app/models/post.rb' do
          subject { file('app/models/post.rb') }
          it { expect(subject).to exist }
          it { expect(subject).to contain 'class Post < ActiveRecord::Base' }
        end
      end
      """
    When I run `rake spec`
    Then the output should contain "4 examples, 0 failures"
