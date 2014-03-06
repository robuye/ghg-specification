module Chassis
  class MAES
    include Component
    def energy
      40
    end

    def weight
      90
    end

    def capacity
      250
    end

    def manufacturer
      "ComStar"
    end
  end

  class MitchellMarkIV
    include Component
    def energy
      180
    end

    def weight
      200
    end

    def capacity
      400
    end

    def manufacturer
      "Mitchell"
    end
  end
end
