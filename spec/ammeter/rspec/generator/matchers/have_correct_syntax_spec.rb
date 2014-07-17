require 'spec_helper'

describe 'have_correct_syntax' do

  describe 'ruby files' do
    subject { '/test.rb' }
    it 'checks if Ruby file has a proper syntax' do
      stub_file subject, "class SomeClass\n  def some_method\n    puts 'Hello world!'\n  end\nend"
      expect(subject).to have_correct_syntax
    end

    it 'checks if Ruby file has an incorrect syntax' do
      stub_file subject, "class SomeClass\ndef some_method\nputs 'Hello world!'"
      expect(subject).to_not have_correct_syntax
    end
  end

  describe 'erb files' do
    subject { '/test.erb' }
    it 'checks if simple ERB file has a proper syntax' do
      stub_file subject, '<% if nonexistent_var == 1 %><a href="#"></a><% end %>'
      expect(subject).to have_correct_syntax
    end

    it 'checks if simple ERB file has an incorrect syntax' do
      stub_file subject, '<% if 1 + 1 %> abc'
      expect(subject).to_not have_correct_syntax
    end

    it 'checks if complex ERB file has a proper syntax' do
      stub_file subject, <<-EOF
<header>
  <h1><%= application_title %></h1>
</header>
<div id="body">
  <table>
  <% @elements.each do |element| %>
    <tr>
      <td><%= element.id %></td>
      <td><%= element.title %></td>
      <td><%= link_to 'Show', element_path(element) %></td>
    </tr>
  <% end %>
  </table>
</div>
      EOF
      expect(subject).to have_correct_syntax
    end

    it 'checks if complex ERB file has an incorrect syntax' do
      stub_file subject, <<-EOF
<div id="broken-example">
  <p>This test should fail because I didn't close an each loop.</p>
  <% @elements.each do |element| %>
    <tr>
      <td><%= element.id %></td>
    </tr>
</div>
      EOF
      expect(subject).to_not have_correct_syntax
    end
  end

  describe 'haml files' do
    subject { '/test.haml' }
    it 'checks if simple Haml file has a proper syntax' do
      stub_file subject, <<-EOF
%a{:href => "#"}= @order.id
      EOF
      expect(subject).to have_correct_syntax
    end

    it 'checks if simple Haml file has an incorrect syntax' do
      stub_file subject, <<-EOF
%a{
      EOF
      expect(subject).to_not have_correct_syntax
    end

    it 'checks if complex Haml file has a proper syntax' do
      stub_file subject, <<-EOF
%header
  %h1= application_title
#body
  %table
    - @elements.each do |element|
      %tr
        %td= element.id
        %td= element.title
        %td= link_to 'Show', element_path(element)
      EOF
      expect(subject).to have_correct_syntax
    end

    it 'checks if complex Haml file has an incorrect syntax' do
      stub_file subject, <<-EOF
#broken-example
  %p This test should fail because of broken indentation
  - @elements.each do |element|
    %tr
       $td= element.id
      EOF
      expect(subject).to_not have_correct_syntax
    end
  end
end
