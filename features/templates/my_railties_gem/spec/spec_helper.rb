require 'bundler/setup'
require 'rails/all'
require 'ammeter/init'

Bundler.require
ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"
