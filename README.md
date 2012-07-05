# Ammeter [![Build Status](https://secure.travis-ci.org/alexrothenberg/ammeter.png)](http://travis-ci.org/alexrothenberg/ammeter)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/alexrothenberg/ammeter)

A gem that makes it easy to write specs for your Rails 3 Generators.

RSpec is using ammeter to 
[spec](https://github.com/rspec/rspec-rails/blob/master/spec/generators/rspec/model/model_generator_spec.rb) 
[its](https://github.com/rspec/rspec-rails/blob/master/spec/generators/rspec/controller/controller_generator_spec.rb) 
[own](https://github.com/rspec/rspec-rails/blob/master/spec/generators/rspec/helper/helper_generator_spec.rb) 
[generators](https://github.com/rspec/rspec-rails/blob/master/spec/generators/rspec/scaffold/scaffold_generator_spec.rb)
and we think you may find it useful too.

An [ammeter](http://en.wikipedia.org/wiki/Ammeter) is used to measure electrical current and 
electricity can be produced by a generator.

# Example

    require 'spec_helper'

    # Generators are not automatically loaded by Rails
    require 'generators/rspec/model/model_generator'

    describe Rspec::Generators::ModelGenerator do
      # Tell the generator where to put its output (what it thinks of as Rails.root)
      destination File.expand_path("../../../../../tmp", __FILE__)
      before do
        prepare_destination
      end

      # using mocks to ensure proper methods are called
      # invoke_all - will call all the tasks in the generator
      it 'should run all tasks in the generator' do
        gen = generator %w(posts)
        gen.should_receive :create_model_spec
        gen.should_receive :create_fixture_file
        capture(:stdout) { gen.invoke_all }
      end

      # invoke_task - will call just the named task in the generator
      it 'should run a specific tasks in the generator' do
        gen = generator %w(posts)
        gen.should_receive     :create_model_spec
        gen.should_not_receive :create_fixture_file
        capture(:stdout) { gen.invoke_task :create_model_spec }
      end

      # custom matchers make it easy to verify what the generator creates
      describe 'the generated files' do
        before do
          run_generator %w(posts)
        end
        describe 'the spec' do
          # file - gives you the absolute path where the generator will create the file
          subject { file('spec/models/posts_spec.rb') }

          # should exist - verifies the file exists
          it { should exist }

          # should contain - verifies the file's contents
          it { should contain /require 'spec_helper'/ }
          it { should contain /describe Posts/ }
        end
        describe 'the migration' do
          subject { file('db/migrate/create_posts.rb') }

          # should be_a_migration - verifies the file exists with a migration timestamp as part of the filename 
          it { should be_a_migration }
        end
      end
    end


# Contributing

* Check out the latest master to make sure the feature hasn’t been implemented or the bug hasn’t been fixed yet
* Check out the issue tracker to make sure someone already hasn’t requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don’t break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

# Copyright

Copyright © 2011 Alex Rothenberg. See LICENSE.txt for further details.
