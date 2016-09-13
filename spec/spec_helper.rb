require 'standalone_migrations'
require 'rspec'
require 'pry'
require './spec/seed_data_helper'

Dir[File.expand_path("../models/*.rb", __dir__)].each { |file| require file }

RSpec.configure do |config|
  config.before(:each) do
    ActiveRecord::Base.establish_connection YAML.load_file('config/database.yml')["test"]
  end

  config.after(:each) do
    ActiveRecord::Base.connection.close
  end
end
