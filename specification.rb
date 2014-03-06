module Specification
  module Core
    module Common
      def and(other)
        And.new(self, other)
      end

      def or(other)
        Or.new(self, other)
      end
    end

    class And
      include Common

      def initialize(*arry_of_specs)
        @specs = arry_of_specs
      end

      def is_satisfied_by?(subject)
        @specs.all? { |spec| spec.is_satisfied_by?(subject) }
      end
    end

    class Or
      include Common

      def initialize(*specs)
        @specs = specs.flatten
      end

      def is_satisfied_by?(subject)
        @specs.any? { |spec| spec.is_satisfied_by?(subject) }
      end
    end
  end
end
