# 使い方
# irbを起動
# require '/Users/tatsuyamatsuhashi/workspace/vending_machine/vending_machine(master).rb'
# （↑のパスは、自動販売機ファイルが入っているパスを指定する）
# 初期設定（自動販売機インスタンスと在庫インスタンスを作成して、vmという変数に代入する）
# vm = VendingMachine.new
# 作成した自動販売機に500円を入れる
# vm.insert(500)
# 投入金額の合計を表示
# vm.total
# 購入可能なジュースを表示
# vm.sale_info
# 売り切れ表示
# vm.sold_out
# 投入したお金を払い戻し
# vm.refund
# ジュースを買う
# vm.purchase('コーラ')
# 売り上げ金額を表示する
# vm.sale_amount
# ジュースのストックを追加
# vm.stock(drink_name: 'コーラ', stock_count: 5)

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
  def refund
    refunded_money = @total
    @total = 0
    refunded_money
  end
  def sale_info
    sale_drinks = @drink_table.map do |drink|
      if drink.stock_count > 0 && drink.price <= @total
        drink_info(drink)
      end
    end
    sale_drinks.compact
  end
  def sold_out
    sold_out_drinks = @drink_table.map do |drink|
      if drink.stock_count == 0
        drink_info(drink)
      end
    end
    sold_out_drinks.compact
  end
  def purchase(drink_name)
    @drink_table.each do |drink|
      if drink.name.include?(drink_name)
        if drink.stock_count.zero?
          return "売り切れだよ"
        elsif drink.price > @total
          return "お金足りないよ"
        else
          change = @total - drink.price
          @total = 0
          drink.stock_count -= 1
          add_sale_amount(drink.price)
          return "#{drink.name}, お釣り: #{change}円"
        end
      end
    end
    "そんなジュース売ってないよ"
  end
  def stock(drink_name:, stock_count:)
    @drink_table.each_with_index do |drink, index|
      if drink.name.include?(drink_name) && Integer === stock_count
        @drink_table[index].stock_count += stock_count
      end
    end
  end
  private
  def add_sale_amount(money)
    @sale_amount += money
  end
  def drink_info(drink)
    "#{drink.name}, #{drink.price}円"
  end
end
class Drink
  attr_accessor :name, :price, :stock_count
  def initialize(name, price, stock_count)
    @name = name
    @price = price
    @stock_count = stock_count
  end
end
