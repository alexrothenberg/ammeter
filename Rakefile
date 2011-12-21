require 'bundler'
require 'bundler/setup'
Bundler::GemHelper.install_tasks

require 'rdoc/task'
require 'rspec'
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

# for cucumber features that create a sample project
def in_example_app(command)
  Dir.chdir("./tmp/example_app/") do
    Bundler.with_clean_env do
      sh command
    end
  end
end
namespace :generate do
  desc "generate a fresh app with rspec installed"
  task :app do |t|
    # unless File.directory?('./tmp/example_app')
      sh "bundle exec rails new ./tmp/example_app -m 'features/templates/generate_example_app.rb' --skip-test-unit"
      sh "cp 'features/templates/rspec.rake' ./tmp/example_app/lib/tasks"
      in_example_app 'rake db:migrate'
      in_example_app 'rails g rspec:install'
      in_example_app 'bundle install'
    # end
  end
end

namespace :clobber do
  desc "clobber the generated app"
  task :app do
    rm_rf "tmp/example_app"
  end
end

task :ci => [:spec, :'clobber:app', :'generate:app', :cucumber]
task :default => :ci
