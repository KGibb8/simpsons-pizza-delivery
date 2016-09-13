# This is used by rake tasks like db:seed, and also for the rails-erd gem.

require 'standalone_migrations'
require './models/driver'

ActiveRecord::Base.establish_connection YAML.load_file('db/config.yml')[ENV["RAILS_ENV"] || ENV["RACK_ENV"] || "development"]
