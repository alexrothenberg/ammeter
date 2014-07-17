require 'aruba/cucumber'

Before do
  @aruba_timeout_seconds = 30
end

def aruba_path(file_or_dir, source_foldername)
  File.expand_path("../../../#{file_or_dir.sub(source_foldername,'aruba')}", __FILE__)
end

def example_app_path(file_or_dir)
  File.expand_path("../../../#{file_or_dir}", __FILE__)
end

def write_symlink(file_or_dir, source_foldername, filename=nil)
  source = example_app_path(file_or_dir)
  target = aruba_path(file_or_dir, source_foldername)
  target = File.join(File.dirname(target), filename) if filename
  system "ln -s #{source} #{target}"
end

def copy_to_aruba_from(gem_or_app_name)
  steps %Q{
    Given a directory named "spec"
  }

  rspec_version = ENV['RSPEC_VERSION']
  rspec_major_version = (rspec_version && rspec_version != 'master') ? rspec_version.split('.')[0] : '3'

  Dir["tmp/#{gem_or_app_name}/*"].each do |file_or_dir|
    if !(file_or_dir =~ /\/spec$/)
      write_symlink(file_or_dir, gem_or_app_name)
    end
  end

  write_symlink("tmp/#{gem_or_app_name}/spec/spec_helper.rb", gem_or_app_name)

  if rspec_major_version == '2'
    # rspec 2.x does not create rails_helper.rb so we create a symlink to avoid cluttering tests
    write_symlink("tmp/#{gem_or_app_name}/spec/spec_helper.rb", gem_or_app_name, 'rails_helper.rb')
  elsif rspec_major_version == '3'
    write_symlink("tmp/#{gem_or_app_name}/spec/rails_helper.rb", gem_or_app_name)
  end
end

Before '@example_app' do
  copy_to_aruba_from('example_app')
end

Before '@railties_gem' do
  copy_to_aruba_from('my_railties_gem')
end

Before '@rails_gem' do
  copy_to_aruba_from('my_rails_gem')
end
