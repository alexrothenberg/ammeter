require "spec_helper"

module Ammeter::RSpec::Rails
  describe GeneratorExampleGroup do
    it { is_expected.to be_included_in_files_in('./spec/generators/') }
    it { is_expected.to be_included_in_files_in('.\\spec\\generators\\') }

    let(:group_class) do
      ::RSpec::Core::ExampleGroup.describe do
        include GeneratorExampleGroup
      end
    end

    it "adds :type => :generator to the metadata" do
      expect(group_class.metadata[:type]).to eq(:generator)
    end

    describe 'an instance of the group' do
      let(:group)     { group_class.new }
      describe 'uses the generator as the implicit subject' do
        let(:generator) { double('generator') }
        it 'sets a generator as subject' do
          allow(group).to receive(:generator).and_return(generator)
          expect(group.subject).to eq generator
        end
      end

      it "allows you to override with explicity subject" do
        group_class.subject { 'explicit' }
        expect(group.subject).to eq 'explicit'
      end

      it 'allows delegation of destination root to ::Rails::Generators::TestCase' do
        group.destination '/some/path'
        expect(group.destination_root).to eq '/some/path'
      end

      describe 'working with files' do
        let(:path_to_gem_root_tmp) { File.expand_path(__FILE__ + '../../../../../../../../tmp') }
        before do
          group.destination path_to_gem_root_tmp
          FileUtils.rm_rf path_to_gem_root_tmp
          FileUtils.mkdir path_to_gem_root_tmp
        end
        it 'should use destination to find relative root file' do
          expect(group.file('app/model/post.rb')).to eq "#{path_to_gem_root_tmp}/app/model/post.rb"
        end

        describe 'migrations' do
          before do
            tmp_db_migrate = path_to_gem_root_tmp + '/db/migrate'
            FileUtils.mkdir_p tmp_db_migrate
            FileUtils.touch(tmp_db_migrate + '/20111010200000_create_comments.rb')
            FileUtils.touch(tmp_db_migrate + '/20111010203337_create_posts.rb')
          end
          it 'should use destination to find relative root file' do
            expect(group.migration_file('db/migrate/create_posts.rb')).to eq "#{path_to_gem_root_tmp}/db/migrate/20111010203337_create_posts.rb"
          end
          it 'should stick "TIMESTAMP" in when migration does not exist' do
            expect(group.migration_file('db/migrate/migration_that_is_not_there.rb')).to eq "#{path_to_gem_root_tmp}/db/migrate/TIMESTAMP_migration_that_is_not_there.rb"
          end
        end
      end
    end
  end
end
