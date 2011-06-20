require 'rails'

# Ensure that Rails has loaded & Initialized
if Rails::VERSION::STRING >= "3.1"
  require 'ammeter/railtie'
else
  require 'ammeter/init'
end

