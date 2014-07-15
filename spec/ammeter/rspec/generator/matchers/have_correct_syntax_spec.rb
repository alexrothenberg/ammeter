require 'spec_helper'

describe 'have_correct_syntax' do

  it 'checks if Ruby file has a proper syntax' do
    allow(File).to receive(:read).with('/test.rb').and_return("class SomeClass\n  def some_method\n    puts 'Hello world!'\n  end\nend")
    expect('/test.rb').to have_correct_syntax
  end

  it 'checks if Ruby file has an incorrect syntax' do
    allow(File).to receive(:read).with('/test.rb').and_return("class SomeClass\ndef some_method\nputs 'Hello world!'")
    expect('/test.rb').to_not have_correct_syntax
  end

  it 'checks if ERB file has a proper syntax' do
    allow(File).to receive(:read).with('/test.erb').and_return('<% if nonexistent_var == 1 %><a href="#"></a><% end %>')
    expect('/test.erb').to have_correct_syntax
  end

  it 'checks if ERB file has an incorrect syntax' do
    allow(File).to receive(:read).with('/test.erb').and_return('<% if 1 + 1 %> abc')
    expect('/test.erb').to_not have_correct_syntax
  end

end
