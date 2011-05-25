require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/rdoctask'
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
      sh "bundle exec rails new ./tmp/example_app -m 'templates/generate_example_app.rb'"
      sh "cp 'templates/rspec.rake' ./tmp/example_app/lib/tasks"
      in_example_app 'rake db:migrate'
      in_example_app 'rails g rspec:install'
      in_example_app 'bundle install'
    # end
  end

end

task :default => [:spec, :'generate:app', :cucumber]
