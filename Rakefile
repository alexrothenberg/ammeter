require 'bundler'
require 'bundler/setup'
Bundler::GemHelper.install_tasks

require 'rdoc/task'
require 'rspec/core'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

task :cleanup_rcov_files do
  rm_rf 'coverage.data'
end

desc "Run all examples"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[--color]
end

Cucumber::Rake::Task.new(:cucumber)

task :ensure_bundler_11 do
  raise 'Bundler 1.1 is a development dependency to build ammeter. Please upgrade bundler.' unless Bundler::VERSION >= '1.1'
end


def create_gem(gem_name)
  template_folder = "features/templates/#{gem_name}"

  Dir.chdir("./tmp") do
    sh "yes | bundle gem -t rspec #{gem_name}"
  end
  sh "cp '#{template_folder}/Gemfile' tmp/#{gem_name}"
  sh "cp '#{template_folder}/#{gem_name}.gemspec' tmp/#{gem_name}"
  sh "cp '#{template_folder}/Rakefile' tmp/#{gem_name}"
  sh "mkdir -p tmp/#{gem_name}/spec"
  sh "cp '#{template_folder}/spec/spec_helper.rb' tmp/#{gem_name}/spec"
  Dir.chdir("./tmp/#{gem_name}") do
    Bundler.unbundled_system 'bundle install'
  end
end

namespace :generate do
  desc "generate a fresh app with rspec installed"
  task :app => :ensure_bundler_11 do |t|
    sh "bundle exec rails new ./tmp/example_app -m 'features/templates/generate_example_app.rb' --skip-test-unit --skip-bootsnap --skip-spring --skip-webpack-install"
    sh "cp 'features/templates/rspec.rake' ./tmp/example_app/lib/tasks"
    Dir.chdir("./tmp/example_app/") do
      Bundler.unbundled_system 'bundle install'
      Bundler.unbundled_system 'rake db:migrate'
      Bundler.unbundled_system 'rails g rspec:install'
    end
  end

  desc "generate a fresh gem that depends on railties"
  task :railties_gem => :ensure_bundler_11 do |t|
    create_gem('my_railties_gem')
  end

  desc "generate a fresh gem that depends on rails"
  task :rails_gem => :ensure_bundler_11 do |t|
    create_gem('my_rails_gem')
  end
end

task :generate => [:'generate:app', :'generate:railties_gem',  :'generate:rails_gem']

namespace :clobber do
  desc "clobber the generated app"
  task :app do
    rm_rf "tmp/example_app"
  end
  task :gem do
    rm_rf "tmp/my_railties_gem"
    rm_rf "tmp/my_rails_gem"
  end
end
task :clobber => [:'clobber:app', :'clobber:gem']

task :ci => [:spec, :clobber, :generate, :cucumber]
task :default => :ci
