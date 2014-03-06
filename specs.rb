require 'specification'
module Specs
  module Class
    class Light
      include Specification::Core::Common

      def is_satisfied_by?(subject)
        subject.total_weight <= 250
      end
    end

    class Heavy
      include Specification::Core::Common

      def is_satisfied_by?(subject)
        subject.total_weight > 250
      end
    end
  end

  module Power
    class Strong
      include Specification::Core::Common
      def is_satisfied_by?(subject)
        subject.weapons.map(&:firepower).inject(&:+).to_i > 170
      end
    end

    class Weak
      include Specification::Core::Common
      def is_satisfied_by?(subject)
        subject.weapons.map(&:firepower).inject(&:+).to_i <= 170
      end
    end

    class None
      include Specification::Core::Common
      def is_satisfied_by?(subject)
        subject.weapons.map(&:firepower).inject(&:+).to_i == 0
      end
    end
  end

  class Manufacturer
    include Specification::Core::Common
    def initialize(manufacturer)
      @manufacturer = manufacturer
    end

    def is_satisfied_by?(subject)
      subject.components.map(&:manufacturer).include?(@manufacturer)
    end
  end

  class SuitableComponentFor
    include Specification::Core::Common
    def initialize(mech)
      @mech = mech
    end

    def is_satisfied_by?(subject)
      @subject = subject
      weight_ok? && energy_ok? #you suck, refactor me?
    end

    private

    def weight_ok?
      (@mech.weight_capacity - @mech.total_weight) >= @subject.weight
    end

    def energy_ok?
      (@mech.energy_capacity - @mech.consumed_energy) >= @subject.energy
    end
  end
end
