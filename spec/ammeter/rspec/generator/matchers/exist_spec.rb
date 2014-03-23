require 'spec_helper'

describe "exist" do
  it 'passes when the file exists' do
    allow(File).to receive(:exist?).with('/some/file/path').and_return(true)
    expect('/some/file/path').to exist
  end
  it 'fails when the file does not exist' do
    allow(File).to receive(:exist?).with('/some/file/path').and_return(false)
    expect('/some/file/path').to_not exist
  end

end
