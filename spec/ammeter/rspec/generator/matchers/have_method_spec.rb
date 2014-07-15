require 'spec_helper'

describe 'have_method' do
  let(:contents) { "class SomeClass\n  def some_method\n    puts 'Hello world!'\n  end\nend" }

  subject { '/some/file/path' }
  before { allow(File).to receive(:read).with('/some/file/path').and_return(contents) }

  it { is_expected.to have_method(:some_method) }
  it { is_expected.to have_method(:some_method).containing("puts 'Hello world!'")}
  it { is_expected.to_not have_method(:some_method).containing("puts 'Good bye cruel world!' ") }
  it { is_expected.to_not have_method(:some_other_method) }
end
