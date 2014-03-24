# rspec3 defines this method in RSpec::Core::MemoizedHelpers
# see https://github.com/rspec/rspec-core/blob/master/lib/rspec/core/memoized_helpers.rb
module RSpec2MemoizedHelpersCompatibility
  def is_expected
    expect(subject)
  end
end