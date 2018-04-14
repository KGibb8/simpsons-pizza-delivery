require 'pry'

ActiveRecord::Base.establish_connection YAML.load_file('db/config.yml')[ENV["RAILS_ENV"] || ENV["RACK_ENV"] || "development"]


Order.destroy_all
UserRole.destroy_all
Role.destroy_all
User.destroy_all

@head_chef = Role.create(name: "Head Chef")
@ass_chef = Role.create(name: "Assistant Chef")
@driver = Role.create(name: "Driver")
@customer = Role.create(name: "Customer")
@manager = Role.create(name: "Administrator")
@tel_controller = Role.create(name: "Telephone Controller")


# Backroom Staff
# Manager
@apu = User.create(name: "Apu Nahasapeemapetilon", username: "apu", password: "1234")
@apu.roles << @manager

# Head Chef
@doris = User.create(name: "Lunchlady Doris", username: "doris", password: "1234")
@doris.roles << @head_chef
# Assistant Chef
@mr_teeny = User.create(name: "Mr. Teeny", username: "mr_teeny", password: "1234")
@mr_teeny.roles << @ass_chef

# Customers
@skinner = User.create(name: "Seymour Skinner", username: "skinner", password: "1234")
@skinner.roles << @customer
@wiggum = User.create(name: "Chief Clancy Wiggum", username: "wiggum", password:  "1234")
@wiggum.roles << @customer
@comic_book_guy = User.create(name: "Comic Book Guy", username: "comic_book_guy", password:   "1234")
@moe = User.create(name: "Moe Szyslak", username: "moe", password:   "1234")
@otto = User.create(name: "Otto Mann", username: "otto", password:  "1234")

# Drivers
@krusty = User.create(name: "Krusty the Clown", username: "krusty", password: "1234")
@radioactive_man = User.create(name: "Radioactive Man", username: "radioactive_man", password: "1234")
@homer = User.create(name: "Homer Simpson", username: "homer", password: "1234")
