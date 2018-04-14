module SeedData
  # When this module is extended into a class or test...
  def self.extended(object)
    # ... make instance variables available.
    object.instance_exec do

      Order.destroy_all
      UserRole.destroy_all
      Role.destroy_all
      User.destroy_all

      @head_chef = Role.create(name: "Head Chef")
      @chef = Role.create(name: "Chef")
      @driver = Role.create(name: "Driver")
      @customer = Role.create(name: "Customer")
      @manager = Role.create(name: "Manager")
      @tel_controller = Role.create(name: "Telephone Controller")

      # Backroom Staff
      # Manager
      @apu = User.create(name: "Apu Nahasapeemapetilon", password: 1234)
      # Head Chef
      @doris = User.create(name: "Lunchlady Doris", password: 1234)
      # Chef
      @mr_teeny = User.create(name: "Mr. Teeny", password: 1234)

      # Customers
      @skinner = User.create(name: "Seymour Skinner", password: 1234)
      @wiggum = User.create(name: "Chief Clancy Wiggum", password:  1234)
      @comic_book_guy = User.create(name: "Comic Book Guy", password:   1234)
      @moe = User.create(name: "Moe Szyslak", password:   1234)
      @otto = User.create(name: "Otto Mann", password:  1234)

      # Drivers
      @krusty = User.create(name: "Krusty the Clown", password: 1234)
      @radioactive_man = User.create(name: "Radioactive Man", password: 1234)
      @homer = User.create(name: "Homer Simpson", password: 1234)


    end
  end
end
