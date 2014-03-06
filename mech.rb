class Mech
  attr_accessor :engine, :chassis, :weapons
  attr_reader :name

  def initialize(name, opts={})
    @engine = opts.delete(:engine)
    @chassis = opts.delete(:chassis)
    @weapons = []
    @name = name
  end

  def total_weight
    components.inject(0) {|sum, e| sum += e.weight}
  end

  def consumed_energy
    components.inject(0) {|sum, e| sum += e.weight}
  end

  def weight_capacity
    return 0 if not chassis
    chassis.capacity
  end

  def energy_capacity
    return 0 if not engine
    engine.capacity
  end

  def inspect
    puts "*****#{name}*****"
    puts "weight: #{total_weight} / #{weight_capacity}"
    puts "energy consumed: #{consumed_energy} / #{energy_capacity}"
    puts "installed components: #{components.join(', ')}"
    puts "firepower: #{weapons.map(&:firepower).inject(&:+).to_i}"
    puts
  end

  def components
    ([engine] + [chassis] + [weapons]).flatten.compact
  end
end
