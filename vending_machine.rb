class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  attr_reader :total, :sale_amount, :drinks
  def initialize
    @total = 0
    @sale_amount = 0
    @drinks = {}
  end
  def insert(money) #お金を投入
    if MONEY.include?(money)
      @total += money
    else
      money
    end
  end
  def payback #お金を払い戻す
    @total.tap{@total = 0}
  end
  def store #飲み物を補充
    cola = Drink.new('cola', 120, 5)
    red_bull = Drink.new('RedBull', 200, 5)
    water = Drink.new('water', 100, 5)
    @drinks = {cola: cola, RedBull: red_bull, water: water}
  end
  def purchasable_drinks #購入できる飲み物を表示
    @drinks.map do |k, v|
      v.name if @total >= v.price && v.stock > 0
    end
  end
  def purchase(drink_name) #飲み物を購入
    if self.purchasable_drinks.include?(drink_name)
      drink = @drinks[drink_name.intern]
      @total -= drink.price
      drink.stock -= 1
      @sale_amount += drink.price
      return self.payback
    end
  end
end
class Drink
  attr_accessor :name, :price, :stock
  def initialize(name, price, stock)
    @name = name
    @price = price
    @stock = stock
  end
end
