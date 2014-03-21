require 'spec_helper'

describe "contain" do

  context "when the file exists" do
    let(:contents) { "This file\ncontains\nthis text" }

    subject { '/some/file/path' }
    before do
      allow(File).to receive(:read).with('/some/file/path').and_return(contents)
    end
    it { is_expected.to contain "This file\ncontains\nthis text" }
    it { is_expected.to contain "This file" }
    it { is_expected.to contain "this text" }
    it { is_expected.to contain /This file/ }
    it { is_expected.to contain /this text/ }
    it { is_expected.to contain "contains", /this text/ }
    it { is_expected.to_not contain /something not there/ }
    it { is_expected.to_not contain /this isn't at the contents/, /neither is this/ }
  end

  context "when the file is not there" do
    it 'raises an error when the file does not exist' do
      expect do
        expect('some/file/that/does/not/exist').to contain 'something'
      end.to raise_error /No such file or directory/
    end
  end
end
