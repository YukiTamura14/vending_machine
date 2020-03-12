# 使い方
# irbを起動
# require '/Users/tatsuyamatsuhashi/workspace/vending_machine/vending_machine(master).rb'
# （↑のパスは、自動販売機ファイルが入っているパスを指定する）

# 初期設定（自動販売機インスタンスと在庫インスタンスを作成して、vmとstockという変数に代入する）
# vm = VendingMachine.new
# stock = Stock.new
# 作成した自動販売機に500円を入れる
# vm.insert(500)
# 投入金額の合計を表示
# vm.total
# stock内のジュース情報を表示
# vm.sale_info
# 売り切れ表示
# vm.sold_out
# 投入したお金を払い戻し
# vm.refund
# ジュースを買う
# vm.purchase('コーラ')
# 売り上げ金額を表示する
# vm.sale_amount

class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  attr_reader :total, :sale_amount
  def initialize
    @total = 0
    @sale_amount = 0
    @coke = Drink.new("コーラ", 120, 5)
    @red_bull = Drink.new("レッドブル", 200, 5)
    @water = Drink.new("水", 100, 5)
    @drink_table = [@coke, @red_bull, @water]
  end
  def insert(money)
    if MONEY.include?(money)
      @total += money
    else
      money
    end
  end
  def reset
    @total = 0
  end
  def add_sale_amount=(money)
    @sale_amount += money
  end
  def refund
    refunded_money = @total
    @total = 0
    refunded_money
  end
  def sale_info
    @drink_table.map do |drink|
      if drink.stock_count > 0 && drink.price <= @total
        "#{drink.name}, #{drink.price}円"
    end
  end
  def sold_out
    @drink_table.map do |drink|
      if drink.stock_count == 0
       "#{drink.name}, #{drink.price}円"
      end
    end
  end
  def purchase(drinkname)
    # drink = Choice.drink_choice(stock.get_drink_table)
    # if drink.stock > 0 && drink.price <= @total
    #   change = @total - drink.price
    #   self.reset
    #   stock.reduce(drink)
    #   self.add_sale_amount=(drink.price)
    #   puts "#{drink.name}を買いました"
    #   puts "#{change}円のお釣りです"
    # elsif drink.stock == 0
    #   puts "売り切れごめんね"
    # elsif drink.price > @total
    #   puts "お金が足りないよ"
    # end
    @drink_table.each do |drink|
      if drink.name.include?(drinkname)
        if drink.stock_count.zero?
          return "売り切れ"
        elsif drink.price > @total
          return "お金足りないよ"
        else
          change = @total - drink.price
          self.reset
          drink.stock_count -= 1
          self.drink.add_sale_amount=(drink.price)
          return "#{drink.name}, お釣り: #{change}円"
        end
      else
        "ナッシング"
      end
    end
  end

  def stock(name, stock_count)
    
  end

  private :add_sale_amount

end
class Drink
  attr_accessor :name, :price, :stock_count
  def initialize(name, price, stock_count)
    @name = name
    @price = price
    @stock_count = stock_count
  end
end
