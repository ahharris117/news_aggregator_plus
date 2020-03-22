ENV["RACK_ENV"] ||= "test"

require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'pry'


require_relative "../server"

set :environment, :test

Capybara.app = Sinatra::Application