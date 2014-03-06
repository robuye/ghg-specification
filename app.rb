$: << './'
require 'pry'
require 'component'
require 'engines'
require 'weapons'
require 'chassis'
require 'mech'
require 'specs'

def mechs_by_spec(spec)
  GARAGE.select {|mech| spec.is_satisfied_by?(mech)}.map(&:name)
end


baby_hitter = Mech.new("Baby Hitter", engine: Engines::Fusion360.new, chassis: Chassis::MitchellMarkIV.new)
baby_hitter.weapons << Weapons::StreakSRM6.new

touche = Mech.new("Touche", engine: Engines::Starfire180XL.new, chassis: Chassis::MAES.new)
touche.weapons << Weapons::GaussRifle.new
touche.weapons << Weapons::GaussRifle.new
touche.weapons << Weapons::GaussRifle.new

mechinator = Mech.new("Mechinator", engine: Engines::Fusion360.new, chassis: Chassis::MAES.new)
mechinator.weapons << Weapons::StreakSRM6.new

drunk_fly = Mech.new("DrunkFly", engine: Engines::Starfire180XL.new, chassis: Chassis::MAES.new)

unfinished = Mech.new("Unfinished", engine: Engines::Starfire180XL.new, chassis: Chassis::MAES.new)

GARAGE = [baby_hitter, touche, mechinator, drunk_fly, unfinished]
WEAPONS = [Weapons::StreakSRM6.new, Weapons::GaussRifle.new]

weak  = mechs_by_spec(Specs::Power::Weak.new)
light =  mechs_by_spec(Specs::Class::Light.new)
unarmed = mechs_by_spec(Specs::Power::None.new)
with_mitchell = mechs_by_spec(Specs::Manufacturer.new('Mitchell'))
with_comstar = mechs_by_spec(Specs::Manufacturer.new('ComStar'))
light_with_mitchell = mechs_by_spec(Specs::Manufacturer.new('Mitchell').and(Specs::Class::Light.new))
heavy_or_unarmed = mechs_by_spec(Specs::Class::Heavy.new.or(Specs::Power::None.new))



binding.pry
