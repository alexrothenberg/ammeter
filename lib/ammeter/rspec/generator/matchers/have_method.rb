RSpec::Matchers.define :have_method do |method|
  chain :containing do |content|
    @method_content = content.strip
  end

  match do |file_path|
    content = File.read(file_path)
    content =~ /(\s+)def #{method}(\(.+\))?(.*?)\n\1end/m && (@method_content.nil? ? true : $3.include?(@method_content))
  end
end
