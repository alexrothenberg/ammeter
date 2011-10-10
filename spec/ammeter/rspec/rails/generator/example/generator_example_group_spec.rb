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
      subject { group }
      let(:generator) { double('generator') }
      before { group.stub(:generator => generator) }
      describe 'uses the generator as the implicit subject' do
        its(:subject) { should == generator }
      end

      describe "allows you to override with explicity subject" do
        before { group_class.subject { 'explicit' } }
        its(:subject) { should == 'explicit' }
      end

      describe 'able to delegate to ::Rails::Generators::TestCase' do
        it 'should know the destination is not set' do
          lambda { group.destination_root_is_set? }.should raise_error "You need to configure your Rails::Generators::TestCase destination root."
        end
        describe 'with a destination root' do
          before { group.destination '/some/path' }
          its(:destination_root)         { should == '/some/path' }
          it 'should know the destination is set' do
            lambda { group.destination_root_is_set? }.should_not raise_error
          end
        end
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

        it 'should use destination to find relative root file' do
          tmp_db_migrate = path_to_gem_root_tmp + '/db/migrate'
          FileUtils.mkdir_p tmp_db_migrate
          FileUtils.touch(tmp_db_migrate + '/20111010200000_create_comments.rb')
          FileUtils.touch(tmp_db_migrate + '/20111010203337_create_posts.rb')

          group.migration_file('db/migrate/create_posts.rb').should == "#{path_to_gem_root_tmp}/db/migrate/20111010203337_create_posts.rb"
        end
      end
    end
  end
end
