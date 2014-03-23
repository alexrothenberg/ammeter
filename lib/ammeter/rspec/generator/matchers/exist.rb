RSpec::Matchers.define :exist do
  match do |file_path|
    File.exist?(file_path)
  end
end
