require './models/user_role'
require './models/role'
require './models/order'
require 'bcrypt'

class User < ActiveRecord::Base
  has_secure_password
  # Could this actually be done from UserRole instead of here from User?
  # Then a given UserRole that is also tied into being a driver could be the only guys that deliver these orders
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :orders

  def is_a(role_name)
    # This misses out on if it's a user in memory with a role
    # self.roles.map(&:name).include? role_name

    # This works properly, even if the user is just in memory
    role = Role.find_by(name: role_name)
    self.user_roles.map(&:role_id).include? role.id
  end

end
