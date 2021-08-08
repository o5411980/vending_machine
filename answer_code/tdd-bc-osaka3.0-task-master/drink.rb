class Drink
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def self.cola
    self.new("コーラ", 120)
  end

  def self.redbull
    self.new("レッドブル", 200)
  end

  def self.water
    self.new("水", 100)
  end
end
