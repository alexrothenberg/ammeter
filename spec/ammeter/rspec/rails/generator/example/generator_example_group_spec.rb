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
    end
  end
end
