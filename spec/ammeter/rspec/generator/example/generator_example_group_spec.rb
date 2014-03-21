require "spec_helper"

module Ammeter::RSpec::Rails
  describe GeneratorExampleGroup do
    it { should be_included_in_files_in('./spec/generators/') }
    it { should be_included_in_files_in('.\\spec\\generators\\') }

    let(:group_class) do
      ::RSpec::Core::ExampleGroup.describe do
        include GeneratorExampleGroup
      end
    end

    it "adds :type => :generator to the metadata" do
      group_class.metadata[:type].should eq(:generator)
    end

    describe 'an instance of the group' do
      let(:group)     { group_class.new }
      let(:generator) { double('generator') }
      before { group.stub(:generator => generator) }
      describe 'uses the generator as the implicit subject' do
        it 'sets a generator as subject' do
          group.subject.should == generator
        end
      end

      it "allows you to override with explicity subject" do
        group_class.subject { 'explicit' }
        group.subject.should == 'explicit'
      end

      it 'allows delegation of destination root to ::Rails::Generators::TestCase' do
        group.destination '/some/path'
        group.destination_root.should == '/some/path'
      end

      describe 'working with files' do
        let(:path_to_gem_root_tmp) { File.expand_path(__FILE__ + '../../../../../../../../tmp') }
        before do
          group.destination path_to_gem_root_tmp
          FileUtils.rm_rf path_to_gem_root_tmp
          FileUtils.mkdir path_to_gem_root_tmp
        end
        it 'should use destination to find relative root file' do
          group.file('app/model/post.rb').should == "#{path_to_gem_root_tmp}/app/model/post.rb"
        end

        describe 'migrations' do
          before do
            tmp_db_migrate = path_to_gem_root_tmp + '/db/migrate'
            FileUtils.mkdir_p tmp_db_migrate
            FileUtils.touch(tmp_db_migrate + '/20111010200000_create_comments.rb')
            FileUtils.touch(tmp_db_migrate + '/20111010203337_create_posts.rb')
          end
          it 'should use destination to find relative root file' do
            group.migration_file('db/migrate/create_posts.rb').should == "#{path_to_gem_root_tmp}/db/migrate/20111010203337_create_posts.rb"
          end
          it 'should stick "TIMESTAMP" in when migration does not exist' do
            group.migration_file('db/migrate/migration_that_is_not_there.rb').should == "#{path_to_gem_root_tmp}/db/migrate/TIMESTAMP_migration_that_is_not_there.rb"
          end
        end
      end
    end
  end
end
