class Role < ActiveRecord::Base
  has_many :user_roles
  has_many :users, through: :user_roles

  def is_a(user_name)
    # This misses out on if it's a user in memory with a role
    # self.roles.map(&:name).include? role_name

    # This works properly, even if the user is just in memory
    user = User.find_by(name: user_name)
    self.user_roles.map(&:user_id).include? user.id
  end
end
