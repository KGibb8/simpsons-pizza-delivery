require 'pry'

ActiveRecord::Base.establish_connection YAML.load_file('db/config.yml')[ENV["RAILS_ENV"] || ENV["RACK_ENV"] || "development"]

Driver.destroy_all
Order.destroy_all

@krusty = Driver.create(name: "Krusty the Clown", can_beer: true, password: "1234")
@mr_teeny = Driver.create(name: "Mr. Teeny", can_beer: true, password: "1234")
@radioactive_man = Driver.create(name: "Radioactive Man", can_beer: true, password: "1234")
@homer = Driver.create(name: "Homer Simpson", can_beer: true, password: "1234")
@bart = Driver.create(name: "Bart Simpson", can_beer: false, password: "1234")
@lisa = Driver.create(name: "Lisa Simpson", can_beer: false, password: "1234")


@order1 = Order.create(is_beer: true, address: "742 Evergreen Terrace, Springfield, US")
@order2 = Order.create(is_beer: true, address: "Moe's Tavern, Springfield, US")
@order3 = Order.create(is_beer: true, address: "The Stolen Lemon Tree, Shelbyville, US")
@order4 = Order.create(is_beer: false, address: "123 Fake Street, Springfield, US")
@order5 = Order.create(is_beer: false, address: "The Kwik-E-Mart, Springfield, US")
@order6 = Order.create(is_beer: true, address: "Springfield Nuclear Power Plant, Springfield, US")
@order7 = Order.create(is_beer: true, address: "La Maison Derrière, Springfield, US")
@order8 = Order.create(is_beer: false, address: "First Church of Springfield, Springfield, US")


binding.pry
