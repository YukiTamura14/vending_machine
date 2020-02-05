# 使い方
# irbを起動
# require '/Users/tatsuyamatsuhashi/workspace/vending_machine/vending_machine.rb'
# （↑のパスは、自動販売機ファイルが入っているパスを指定する）
# 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
# vm = VendingMachine.new
# 作成した自動販売機に500円を入れる
# vm.insert(500)
# 投入金額の合計を表示
# vm.total
# 自動販売機内のジュース情報を表示
# vm.sale_info
# 投入したお金を払い戻し
# vm.refund
# ジュースを買う
# vm.purchase
# 売り上げ金額を表示する
# vm.sale_amount

class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    @total = 0
    @sale_amount = 0
  end
  def insert(money)
    if MONEY.include?(money)
      # Calculator.sum(money)
      @total += money
    else
      money
    end
  end
  def total
    # Calculator.get_total
    @total
  end
  def reset
    @total = 0
  end
  def sale_amount
    #Calculator.get_sale_amount
    @sale_amount
  end
  def add_sale_amount=(money)
    @sale_amount += money
  end
  # def refund
  #   refunded_money = Calculator.get_total
  #   Calculator.total_reset
  #   puts "#{refunded_money}円の払い戻しです"
  # end
  def sale_info
    puts "買いますか？"
    Stock.get_drink_table.each do |drink|
      # if drink.stock > 0 && drink.price <= Calculator.get_total
      if drink.stock > 0 && drink.price <= @total
        puts "#{drink.name}, #{drink.price}円"
      end
    end

    puts "======================="
    puts "売り切れごめんね"
    Stock.get_drink_table.each do |drink|
      if drink.stock == 0
        puts "#{drink.name}, #{drink.price}円"
      end
    end

    # puts "======================="
    # puts "お金が足りないよ"
    # Stock.get_drink_table.each do |drink|
    #   if drink.price > Calculator.get_total
    #     puts "#{drink.name}, #{drink.price}円"
    #   end
    # end
  end
#   def purchase
#     drink = Choice.drink_choice
#     if drink.stock > 0 && drink.price <= Calculator.get_total
#       change = Calculator.get_total - drink.price
#       Calculator.total_reset
#       Stock.reduce(drink)
#       Calculator.add_sale_amount=(drink.price)
#       puts "#{drink.name}を買いました"
#       puts "#{change}円のお釣りです"
#     elsif drink.stock == 0
#       puts "売り切れごめんね"
#     elsif drink.price > Calculator.get_total
#       puts "お金が足りないよ"
#     end
#   end
# end
# class Drink
#   attr_accessor :name, :price, :stock
#   def initialize(name, price)
#     @name = name
#     @price = price
#     @stock = 5
#   end
# end
class Stock
  @coke = Drink.new("コーラ", 120)
  @red_bull = Drink.new("レッドブル", 200)
  @water = Drink.new("水", 100)
  @drink_table = [@@coke, @@red_bull, @@water]
  def self.get_drink_table
    @drink_table
  end
  def self.reduce(drink)
    @@coke.stock -= 1 if @@coke.name == drink.name
    @@red_bull.stock -= 1 if @@red_bull.name == drink.name
    @@water.stock -= 1 if @@water.name == drink.name
  end
end
# class Choice
#   def self.drink_choice
#     drinks = Stock.get_drink_table
#     puts "どれを買いますか"
#     puts "コーラ：1、レッドブル：2、水：3"
#     answer = gets.to_i
#     case answer
#       when 1
#         drink = drinks[0]
#       when 2
#         drink = drinks[1]
#       when 3
#         drink = drinks[2]
#       else
#         puts "1,2,3を選んでください"
#         self.drink_choice
#     end
#   end
end
# drink = Drink.new
# stock = Stock.new
# choice = Choice.new
