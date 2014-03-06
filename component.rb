module Component
  def weight
    raise NotImplementedError, "Component must have weight"
  end

  def energy
    raise NotImplementedError, "Component must define enegry delta"
  end

  def to_s
    self.class.name
  end
end
