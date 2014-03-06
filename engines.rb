module Engines
  class Starfire180XL
    include Component
    def weight
      20
    end

    def energy
      10
    end

    def capacity
      200
    end

    def manufacturer
      "ComStar"
    end
  end

  class Fusion360
    include Component
    def weight
      60
    end

    def energy
      30
    end

    def capacity
      360
    end

    def manufacturer
      "ComStar"
    end
  end
end
