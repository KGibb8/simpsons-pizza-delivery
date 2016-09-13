require './models/order'
require 'bcrypt'

class Driver < ActiveRecord::Base
  has_secure_password
  has_many :orders
end
