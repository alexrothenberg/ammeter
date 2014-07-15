RSpec::Matchers.define :have_correct_syntax do
  match do |file_path|
    source = File.read(file_path)
    extension = File.extname(file_path)
    case extension
      when '.rb', '.rake'
        check_ruby_syntax(source)
      when '.rhtml', '.erb'
        check_erb_syntax(source)
      when '.haml'
        check_ruby_syntax(source)
      else
        raise "Checking syntax for #{extension} files is not yet supported"
    end

  end

  define_method :check_ruby_syntax do |code|
    begin
      eval('__crash_me__;' + code)
    rescue SyntaxError
      false
    rescue NameError
      true
    end
  end

  define_method :check_erb_syntax do |code|
    require 'erb'

    begin
      ERB.new('<% __crash_me__ %>' + code).run
    rescue SyntaxError
      false
    rescue NameError
      true
    end
  end

  define_method :check_haml_syntax do |code|
    require 'haml'

    begin
      Haml::Engine.new(code)
    rescue SyntaxError
      false
    rescue NameError
      true
    end
  end

end
