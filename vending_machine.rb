class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  attr_reader :total, :sale_amount, :drinks
  def initialize
    @total = 0
    @sale_amount = 0
    @drinks = []
  end
  def insert(money) #お金を投入する
    if MONEY.include?(money)
      @total += money
    else
      money
    end
  end
  def payback #お金を払い戻す
    @total.tap{@total = 0}
  end
  def store #飲み物を補充する
    cola = Drink.new('cola', 120, 5)
    red_bull = Drink.new('Red Bull', 200, 5)
    water = Drink.new('water', 100, 5)
    @drinks = [cola, red_bull, water]
  end
  def purchasable? #購入できる飲み物の確認
    purchasable_drinks = []
    @drinks.each do |drink|
      if @total >= drink.price && drink.stock > 0
        purchasable_drinks.push(drink.name)
      end
    end
    purchasable_drinks
  end
  def purchase(drink_name) #飲み物を購入する
    @drinks.each do |drink|
      if drink.name == drink_name
        if @total < drink.price || drink.stock == 0
          return false
        else
          @total -= drink.price
          drink.stock -= 1
          @sale_amount += drink.price
          return self.payback
        end
      end
    end
  end
  false
end
class Drink
  attr_accessor :name, :price, :stock
  def initialize(name, price, stock)
    @name = name
    @price = price
    @stock = stock
  end
end
