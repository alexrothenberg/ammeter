# see https://github.com/cucumber/aruba#jruby-tips
Aruba.configure do |config|
  config.before_cmd do |cmd|
    set_env('JRUBY_OPTS', "-X-C #{ENV['JRUBY_OPTS']}") # disable JIT since these processes are so short lived
    set_env('JAVA_OPTS', "-d32 #{ENV['JAVA_OPTS']}") # force jRuby to use client JVM for faster startup times
  end
end if RUBY_PLATFORM == 'java'

# MRI 1.8.7 does not define RUBY_ENGINE
if defined?(RUBY_ENGINE) && %w(jruby rbx).include? RUBY_ENGINE
  Before do
    @aruba_timeout_seconds = 30
  end
end
