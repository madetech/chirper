RACK_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(RACK_ENV)
require './lib/loader.rb'

$stdout.sync = true

run DeliveryMechanism::WebRoutes
