class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  has_many :orders
end
