class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  attr_reader :total, :sale_amount, :drinks
  def initialize(drinks = {}, sale_amount = 0)
    @total = 0
    @sale_amount = sale_amount
    @drinks = drinks
  end
  def insert(money) #お金を投入
    if MONEY.include?(money)
      @total += money
    else
      money
    end
  end
  def payback #お金を払い戻す
    # [@total, VendingMachine.new(@drinks, @sale_amount)]
    # 普通にpayback_amountとかに一回寄せた方が普通の書き方
    payback_amount = @total
    @total = 0
    payback_amount
    # @total.tap{@total = 0}
    # tapメソッド：現場で使います(内容見たい、デバッグ、表示するのが一番の目的)
    # hoge_list.tap do |hoge_list|
      # p hoge_list
    # end
  end
  def store #飲み物を補充
    # cola = DrinkLane.new('cola', 120, 5)
    # red_bull = DrinkLane.new('RedBull', 200, 5)
    # water = DrinkLane.new('water', 100, 5)
    # @drinks = {cola: cola, RedBull: red_bull, water: water}
    add_lane(DrinkLane.new('cola', 120, 5))
    add_lane(DrinkLane.new('RedBull', 200, 5))
    add_lane(DrinkLane.new('water', 100, 5))
    # ってなってる方がそれっぽい。自販機にLaneを追加しまくってると
  end
  def add_lane(drink_lane)
    raise('同じレーンは追加できません！') if already_exist?(drink_lane)
    @drinks[drink_lane.name.to_sym] = drink_lane
  end
  def already_exist?(drink_lane)
    @drinks.keys.include?(drink_lane.name.to_sym)
  end
  def purchasable_drinks #購入できる飲み物を表示
    @drinks.values.select do |drink_lane|
      @total >= drink_lane.price && drink_lane.stock > 0
    end.map(&:name)
    # これ↓と一緒(end.map(&:name))
    # end.map do |drink_lane|
    #   drink_lane.name
    # end

    # @drinks.map do |k, v|
    #   @total >= v.price && v.stock > 0
    # end.compact
  end
  def purchase(drink_name) #飲み物を購入
    if purchasable_drinks.include?(drink_name)
      drink_lane = drink_lane_by_name(drink_name)
      @total -= drink_lane.price
      @sale_amount += drink_lane.price
      drink_lane.remove_stock
      drink.stock -= 1
      payback
    end
  end
  def drink_lane_by_name(drink_name)
    # DrinkLane.find_by(name: drink_name) #どっちの可能性もあり得る
    @drinks[drink_name.intern]
  end
end
class DrinkLane
  attr_reader :name, :price, :stock
  def initialize(name, price, stock)
    @name = name
    @price = price
    @stock = stock
  end
  def add_drink
    @stock += 1
  end
  def remove_stock
    @stock -= 1
  end
end
# class Drink #drink１つ1つをオブジェクト(缶)として扱う設計はあり得るのはあり得るけど、やって嬉しいかどうか(YAGNI)。本当に現実考えたらこっちかもしれない。だけど、いまそこまでの抽象化が必要か
#   attr_reader :serial_number, :name, :price
#   def initialize(serial_number, name, price)
#     @serial_number = serial_number
#     @name = name
#     @price = price
#   end
# end

10.times { @stocks << drink }
