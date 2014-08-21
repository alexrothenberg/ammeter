module Ammeter
  class OutputCapturer
    # Is this thread safe!?!?
    # This won't work with sub-processes
    def self.capture(io, &block)
      case io
      when :stdout
        capture_stdout(&block)
      when :stderr
        capture_stderr(&block)
      else
        raise "Unknown IO #{io}"
      end
    end

    def self.capture_stdout(&block)
      captured_stream = StringIO.new

      orginal_io, $stdout = $stdout, captured_stream

      block.call

      captured_stream.string
    ensure
      $stdout = orginal_io
    end

    def self.capture_stderr(&block)
      captured_stream = StringIO.new

      orginal_io, $stderr = $stderr, captured_stream

      block.call

      captured_stream.string
    ensure
      $stderr = orginal_io
    end
  end
end