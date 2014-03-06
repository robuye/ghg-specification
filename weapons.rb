module Weapons
  class GaussRifle
    include Component
    def weight
      20
    end

    def energy
      50
    end

    def range
      200
    end

    def firepower
      50
    end

    def manufacturer
      "Mitchell"
    end
  end

  class StreakSRM6
    include Component
    def weight
      100
    end

    def energy
      80
    end

    def range
      80
    end

    def firepower
      200
    end

    def manufacturer
      "ComStar"
    end
  end
end
