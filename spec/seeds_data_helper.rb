module SeedData
  # When this module is extended into a class or test...
  def self.extended(object)
    # ... make instance variables available.
    object.instance_exec do

      Driver.destroy_all
      Order.destroy_all

      @krusty = Driver.create(name: "Krusty the Clown", can_beer: true)
      @mr_teeny = Driver.create(name: "Mr. Teeny", can_beer: true)
      @radioactive_man = Driver.create(name: "Radioactive Man", can_beer: true)
      @homer = Driver.create(name: "Homer Simpson", can_beer: true)
      @bart = Driver.create(name: "Bart Simpson", can_beer: false)
      @lisa = Driver.create(name: "Lisa Simpson", can_beer: false)

    end
  end
end
