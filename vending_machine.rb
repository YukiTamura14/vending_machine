class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  attr_reader :total, :sale_amount, :drinks
  def initialize
    @total = 0
    @sale_amount = 0
    # @drinks = []
    @drinks = {}
  end
  def insert(money) #投入する
    if MONEY.include?(money)
      @total += money
    else
      money
    end
  end
  def payback #払い戻す
    @total.tap{@total = 0}
  end
  def store #格納する
    cola = Drink.new('cola', 120, 5)
    red_bull = Drink.new('Red Bull', 200, 5)
    water = Drink.new('water', 100, 5)
    # @drinks = [cola, red_bull, water]
    @drinks = {cola: cola, red_bull: red_bull, water: water}
  end
  def purchasable_drinks #購入できるかどうかの確認
    # @drinks.map do |drink|
    #   drink.name if @total >= drink.price && drink.stock > 0
    # end
    @drinks.map do |k, v|
      v.name if @total >= v.price && v.stock > 0
    end
  end
  def purchase(drink_name) #購入する
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
