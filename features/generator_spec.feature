@example_app
Feature: generator spec

  Generator specs live in spec/generators. In order to access
  the generator's methods you can call them on the "generator" object.

  Background: A simple generator
    Given a file named "lib/generators/awesome/awesome_generator.rb" with:
      """
      class AwesomeGenerator < Rails::Generators::NamedBase
        source_root File.expand_path('../templates', __FILE__)
        class_option :super, :type => :boolean, :default => false

        def create_awesomeness
          template 'awesome.html', File.join('public', name, "#{"super_" if options[:super]}awesome.html")
        end

        def create_lameness
          template 'lame.html', File.join('public', name, "#{"super_" if options[:super]}lame.html")
        end
      end
      """
    And a file named "lib/generators/awesome/templates/awesome.html" with:
      """
      This is an awesome file
      """
    And a file named "lib/generators/awesome/templates/lame.html" with:
      """
      This is a lame file
      """

  Scenario: A spec that runs the entire generator
    Given a file named "spec/generators/awesome_generator_spec.rb" with:
      """
      require "spec_helper"
      require 'generators/awesome/awesome_generator'

      describe AwesomeGenerator do
        before { run_generator %w(my_dir) }
        describe 'public/my_dir/awesome.html' do
          subject { file('public/my_dir/awesome.html') }
          it { is_expected.to exist }
          it { is_expected.to contain 'This is an awesome file' }
          it { is_expected.to_not contain 'This text is not in the file' }
        end
        describe 'public/my_dir/lame.html' do
          subject { file('public/my_dir/lame.html') }
          it { is_expected.to exist }
          it { is_expected.to contain 'This is a lame file' }
          it { is_expected.to_not contain 'This text is not in the file' }
        end
      end
      """
    When I run `rake spec`
    Then the output should contain "6 examples, 0 failures"

  Scenario: A spec that runs one task in the generator
    Given a file named "spec/generators/another_awesome_generator_spec.rb" with:
      """
      require "spec_helper"
      require 'generators/awesome/awesome_generator'

      describe AwesomeGenerator do
        arguments %w(another_dir)

        before { invoke_task :create_awesomeness }
        describe 'public/another_dir/awesome.html' do
          subject { file('public/another_dir/awesome.html') }
          it { is_expected.to exist }
          it { is_expected.to contain 'This is an awesome file' }
          it { is_expected.to_not contain 'This text is not in the file' }
        end
        describe 'public/another_dir/lame.html' do
          subject { file('public/another_dir/lame.html') }
          it { should_not exist }
        end
      end
      """
    When I run `rake spec`
    Then the output should contain "4 examples, 0 failures"

  Scenario: A spec with some failures shows nice error messages
    Given a file named "spec/generators/awesome_generator_spec.rb" with:
      """
      require "spec_helper"
      require 'generators/awesome/awesome_generator'

      describe AwesomeGenerator do
        before { run_generator %w(my_dir) }
        describe 'public/my_dir/awesome.html' do
          subject { file('public/my_dir/awesome.html') }
          it { is_expected.to_not contain 'This is an awesome file' }
          it { is_expected.to     contain 'This text is not in the file' }
          it { is_expected.to_not exist }
        end
        describe 'public/my_dir/non_existent.html' do
          subject { file('public/my_dir/non_existent.html') }
          it { is_expected.to exist }
        end
        describe 'db/migrate/non_existent_migration.rb' do
          subject { migration_file('db/migrate/non_existent_migration.rb') }
          it { is_expected.to exist }
        end
      end
      """
    When I run `rake spec`
    Then the output should contain "5 examples, 5 failures"
     And the output should contain:
       """
       /public/my_dir/awesome.html to not contain "This is an awesome file" but it did
       """
     And the output should contain:
       """
       /public/my_dir/awesome.html to contain "This text is not in the file" but it contained "This is an awesome file"
       """
     And the output should contain:
       """
       /public/my_dir/awesome.html" not to exist
       """
     And the output should contain:
       """
       /public/my_dir/non_existent.html" to exist
       """
     And the output should contain:
       """
       db/migrate/TIMESTAMP_non_existent_migration.rb" to exist
       """

   Scenario: Can specify arguments separately from running the generator
     Given a file named "spec/generators/awesome_generator_spec.rb" with:
       """
       require "spec_helper"
       require 'generators/awesome/awesome_generator'

       describe AwesomeGenerator do
         arguments %w(my_dir --super)

         before { generator.invoke_all }
         describe 'public/my_dir/super_awesome.html' do
           subject { file('public/my_dir/super_awesome.html') }
           it { is_expected.to exist }
         end
         describe 'public/my_dir/super_lame.html' do
           subject { file('public/my_dir/super_lame.html') }
           it { is_expected.to exist }
         end
       end
       """
     When I run `rake spec`
     Then the output should contain "2 examples, 0 failures"

  Scenario: A generator that creates a migration
    Given a file named "spec/generators/a_migration_spec.rb" with:
      """
      require "spec_helper"
      require 'rails/generators/active_record/migration/migration_generator'

      describe ActiveRecord::Generators::MigrationGenerator do
        before { run_generator %w(create_posts) }
        subject { migration_file('db/migrate/create_posts.rb') }
        it { is_expected.to exist }
        it { is_expected.to be_a_migration }
        it { is_expected.to contain 'class CreatePosts < ActiveRecord::Migration' }
      end
      """
    When I run `rake spec`
    Then the output should contain "3 examples, 0 failures"

  Scenario: Can tell the generator where to put its files
    Given a file named "spec/generators/awesome_generator_spec.rb" with:
      """
      require "spec_helper"
      require 'generators/awesome/awesome_generator'

      describe AwesomeGenerator do
        destination Rails.root + 'tmp/generated_files'

        before { run_generator %w(my_dir --super) }
        describe 'public/my_dir/super_awesome.html' do
          subject { file('public/my_dir/super_awesome.html') }
          it { is_expected.to eq "#{Rails.root}/tmp/generated_files/public/my_dir/super_awesome.html" }
          it { is_expected.to exist }
        end
      end
      """
    When I run `rake spec`
    Then the output should contain "2 examples, 0 failures"



