RSpec::Matchers.define :contain do |*expected_contents|
  match do |file_path|
    @actual_contents = File.read(file_path)
    not_found_expectations.empty?
  end

  match_when_negated do |file_path|
    @actual_contents = File.read(file_path)
    found_expectations.empty?
  end

  failure_message do |file_path|
    "expected the file #{file_path} to contain " +
      if expected_contents.many?
        "#{expected_contents.map(&:inspect).to_sentence} but " +
          "#{not_found_expectations.map(&:inspect).to_sentence} #{not_found_expectations.many? ? 'were' : 'was'} not found"
      else
        "#{expected_contents.first.inspect} but it contained #{@actual_contents.inspect}"
      end
  end

  failure_message_when_negated do |file_path|
    "expected the file #{file_path} to not contain " +
      if expected_contents.many?
        "#{expected_contents.map(&:inspect).to_sentence} but " +
          "#{found_expectations.map(&:inspect).to_sentence} #{found_expectations.many? ? 'were' : 'was'} found"
      else
        "#{expected_contents.first.inspect} but it did"
      end
  end

  define_method :found_expectations do
    @found_expectations ||= expected_contents.select do |expected_content|
      case expected_content
        when String
          @actual_contents.include? expected_content
        when Regexp
          @actual_contents =~ expected_content
      end
    end
  end

  define_method :not_found_expectations do
    @not_found_expectations ||= expected_contents - found_expectations
  end
end
