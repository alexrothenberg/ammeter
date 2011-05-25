require 'aruba/cucumber'

Before do
  @aruba_timeout_seconds = 10
end

def aruba_path(file_or_dir)
  File.expand_path("../../../#{file_or_dir.sub('example_app','aruba')}", __FILE__)
end

def example_app_path(file_or_dir)
  File.expand_path("../../../#{file_or_dir}", __FILE__)
end

def write_symlink(file_or_dir)
  source = example_app_path(file_or_dir)
  target = aruba_path(file_or_dir)
  system "ln -s #{source} #{target}"
end

Before do
  steps %Q{
    Given a directory named "spec"
  }

  Dir['tmp/example_app/*'].each do |file_or_dir|
    if !(file_or_dir =~ /spec$/)
      write_symlink(file_or_dir)
    end
  end

  ["spec/spec_helper.rb"].each do |file_or_dir|
    write_symlink("tmp/example_app/#{file_or_dir}")
  end
end
