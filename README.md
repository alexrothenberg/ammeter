# Rails-Generator-Spec

A gem that makes it easy to write specs for your Rails 3 Generators.

# Example

    require 'spec_helper'
    require 'generators/rspec/model/model_generator'

    describe Rspec::Generators::ModelGenerator do
      # Tell the generator where to put its output (what it thinks of as Rails.root)
      destination File.expand_path("../../../../../tmp", __FILE__)
      before do
        prepare_destination
      end

      # using mocks to ensure proper methods are called
      it 'should run both the model and fixture tasks' do
        gen = generator %w(posts)
        gen.should_receive :create_model_spec
        gen.should_receive :create_fixture_file
        capture(:stdout) { gen.invoke_all }
      end

      describe 'checking for output' do
        subject { file('spec/models/posts_spec.rb') }
        before do
          run_generator %w(posts)
        end
        it { should exist }
        it { should contain /require 'spec_helper'/ }
        it { should /describe Posts/ }
        it 'should have created a migration' do
          file('db/migrate/create_posts.rb).should be_a_migration
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
