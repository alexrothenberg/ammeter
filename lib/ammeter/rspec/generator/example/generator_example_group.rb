require 'rails/generators'
require 'active_support/core_ext'
require 'rspec/rails/adapters'
require 'rspec/rails/example/rails_example_group'
require 'tmpdir'
require 'fileutils'

module Ammeter
  module RSpec
    module Rails
      # Delegates to Rails::Generators::TestCase to work with RSpec.
      module GeneratorExampleGroup
        extend ActiveSupport::Concern
        include ::RSpec::Rails::RailsExampleGroup

        DELEGATED_METHODS = [:capture, :destination_root, :current_path, :generator_class]
        module ClassMethods
          mattr_accessor :test_unit_test_case_delegate
          delegate :default_arguments, :to => :'self.test_unit_test_case_delegate'
          DELEGATED_METHODS.each do |method|
            delegate method,  :to => :'self.test_unit_test_case_delegate'
          end
          delegate :destination, :arguments, :to => ::Rails::Generators::TestCase

          def prepare_destination
            self.test_unit_test_case_delegate.send :prepare_destination
          end

          def ensure_current_path
            self.test_unit_test_case_delegate.send :ensure_current_path
          end
          
          def initialize_delegate
            self.test_unit_test_case_delegate = ::Rails::Generators::TestCase.new 'pending'
            self.test_unit_test_case_delegate.class.tests(describes)
            @generator = nil
          end

          def generator(given_args=self.default_arguments, config={})
            @generator ||= begin
              args, opts = Thor::Options.split(given_args)
              self.test_unit_test_case_delegate.generator(args, opts, config)
            end
          end

          def run_generator(given_args=self.default_arguments, config={})
            capture(:stdout) { generator(given_args, config).invoke_all }
          end
        end

        def invoke_task name
          capture(:stdout) { generator.invoke_task(generator_class.all_tasks[name.to_s]) }
        end
      
        included do
          delegate :generator, :run_generator, :destination, :arguments, :ensure_current_path, :to => :'self.class'
          DELEGATED_METHODS.each do |method|
            delegate method,  :to => :'self.class'
          end
          
          def prepare_destination
            self.class.send :prepare_destination
          end
          
          ::Rails::Generators::TestCase.destination File.expand_path('ammeter', Dir.tmpdir)
          initialize_delegate

          subject { generator }

          before do
            self.class.initialize_delegate
            prepare_destination
          end
          after do
            # ensure_current_path
          end
          metadata[:type] = :generator
        end

        def file relative
          File.expand_path(relative, destination_root)
        end
        def migration_file relative
          file_path = file(relative)
          migration_file = Dir.glob("#{File.dirname(file_path)}/[0-9]*_#{File.basename(file_path)}").first
          migration_file = "#{File.dirname(file_path)}/TIMESTAMP_#{File.basename(file_path)}" if migration_file.nil?
          migration_file
        end
      end
    end
  end
end