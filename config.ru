RACK_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(RACK_ENV)
require_relative './bin/seeds.rb'
require './lib/loader.rb'

$stdout.sync = true

run Seeds.execute
run DeliveryMechanism::WebRoutes
