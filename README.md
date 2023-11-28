# Ammeter [![Ammeter CI](https://github.com/alexrothenberg/ammeter/actions/workflows/ci.yml/badge.svg)](https://github.com/alexrothenberg/ammeter/actions/workflows/ci.yml) [![Code Climate](https://codeclimate.com/github/alexrothenberg/ammeter.png)](https://codeclimate.com/github/alexrothenberg/ammeter) [![Gem Version](https://badge.fury.io/rb/ammeter.png)](http://badge.fury.io/rb/ammeter)


A gem that makes it easy to write specs for your Rails 3 Generators.

RSpec is using ammeter to
[spec](https://github.com/rspec/rspec-rails/blob/master/spec/generators/rspec/model/model_generator_spec.rb)
[its](https://github.com/rspec/rspec-rails/blob/master/spec/generators/rspec/controller/controller_generator_spec.rb)
[own](https://github.com/rspec/rspec-rails/blob/master/spec/generators/rspec/helper/helper_generator_spec.rb)
[generators](https://github.com/rspec/rspec-rails/blob/master/spec/generators/rspec/scaffold/scaffold_generator_spec.rb)
and we think you may find it useful too.

An [ammeter](http://en.wikipedia.org/wiki/Ammeter) is used to measure electrical current and
electricity can be produced by a generator.

# Installation
Add this line to your Gemfile (or gemspec):

```ruby
gem 'ammeter'
```

And then execute:
```bash
$ bundle
```

Add:
```ruby
require 'ammeter/init'
```
To your `spec/spec_helper.rb`.

# Example

```ruby
require 'spec_helper'

# Generators are not automatically loaded by Rails
require 'generators/rspec/model/model_generator'

describe Rspec::Generators::ModelGenerator, :type => :generator do
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

      # is_expected_to contain - verifies the file's contents
      it { is_expected_to contain /require 'spec_helper'/ }
      it { is_expected_to contain /describe Posts/ }
    end
    describe 'the migration' do
      subject { migration_file('db/migrate/create_posts.rb') }

      # is_expected_to be_a_migration - verifies the file exists with a migration timestamp as part of the filename
      it { is_expected_to be_a_migration }
      it { is_expected_to contain /create_table/ }
    end
  end
end
```

# Available matchers

- `contain` - verifies the file's contents
- `be_a_migration` - verifies the file exists with a migration timestamp as part of the filename
- `have_method` - verifies the file (or a class withing it) implements a method
- `have_correct_syntax` - verifies the file has correct syntax and is not broken (works for .rb, .erb and .haml files)

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
