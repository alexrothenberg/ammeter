@example_app
Feature: generator spec

  Generator specs live in spec/generators. In order to access
  the generator's methods you can call them on the "generator" object.

  Background: A generator that uses "hook_for"
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

  Scenario: A spec that runs the entire generator
    Given a file named "spec/generators/resourceful_generator_spec.rb" with:
      """
      require "spec_helper"
      require 'generators/resourceful/resourceful_generator'

      describe ResourcefulGenerator do
        before { run_generator %w(post) }
        describe 'app/controller/posts_controller.rb' do
          subject { file('app/controllers/posts_controller.rb') }
          it { is_expected.to exist }
          it { is_expected.to contain 'class PostsController < ResourcefulController' }
        end

        describe 'app/models/post.rb' do
          subject { file('app/models/post.rb') }
          it { is_expected.to exist }
          it { is_expected.to contain 'class Post < ActiveRecord::Base' }
        end
      end
      """
    When I run `rake spec`
    Then the output should contain "4 examples, 0 failures"


