# https://blog.jnito.com/entry/2013/05/22/073525 から引用

class Drink
  attr_reader :name, :price

  def self.cola
    self.new 120, :cola
  end

  def self.redbull
    self.new 200, :redbull
  end

  def self.water
    self.new 100, :water
  end

  def initialize price, name
    @name = name
    @price = price
  end

  def ==(another)
    self.name == another.name
  end

  def eql?(another)
    self == another
  end

  def hash
    name.hash
  end

  def to_s
    "<Drink: name=#{name}, price=#{price}>"
  end
end

class VendingMachine
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze

  attr_reader :total, :sale_amount

  def initialize
    @total = 0
    @sale_amount = 0
    @drink_table = {}
    5.times { store Drink.cola }
  end

  def insert(money)
    AVAILABLE_MONEY.include?(money) ?
      nil.tap { @total += money } : money
  end

  def refund
    total.tap { @total = 0 }
  end

  def store(drink)
    nil.tap do
      @drink_table[drink.name] =
        { price: drink.price,
          drinks: [] } unless @drink_table.has_key? drink.name
      @drink_table[drink.name][:drinks] << drink
    end
  end

  def purchase(drink_name)
    if purchasable? drink_name
      drink = @drink_table[drink_name][:drinks].pop
      @sale_amount += drink.price
      @total -= drink.price
      [drink, refund]
    end
  end

  def purchasable?(drink_name)
    purchasable_drink_names.include? drink_name
  end

  def purchasable_drink_names
    @drink_table.select{|_, info|
      info[:price] <= total && info[:drinks].any? }.keys
  end

  def stock_info
    Hash[@drink_table.map {|name, info|
      [name, { price: info[:price], stock: info[:drinks].size }]
    }]
  end
end
