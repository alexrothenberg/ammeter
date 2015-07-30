require "spec_helper"
require 'generators/awesome/awesome_generator'

describe AwesomeGenerator do
  before { run_generator %w(my_dir) }
  describe 'public/my_dir/awesome.html' do
    subject { file('public/my_dir/awesome.html') }
    it { expect(subject).to exist }
    it { expect(subject).to contain 'This is an awesome file' }
    it { expect(subject).to_not contain 'This text is not in the file' }
  end
end