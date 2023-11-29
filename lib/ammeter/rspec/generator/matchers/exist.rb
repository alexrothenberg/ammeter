# DEPRECATED: use `expect(Pathname.new(path)).to exist` instead
RSpec::Matchers.define :exist do |*expected|
  match do |file_path|
    if !(file_path.respond_to?(:exist?) || file_path.respond_to?(:exists?))
      ActiveSupport::Deprecation.warn "The `exist` matcher overrides one built-in by RSpec; use `expect(Pathname.new(path)).to exist` instead"
      File.exist?(file_path)
    else
      RSpec::Matchers::BuiltIn::Exist.new(*expected).matches?(file_path)
    end
  end
end
