class AwesomeGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  class_option :super, :type => :boolean, :default => false

  def create_awesomeness
    template 'awesome.html', File.join('public', name, "#{"super_" if options[:super]}awesome.html")
  end
end