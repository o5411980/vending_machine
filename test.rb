# このコードをコピペしてrubyファイルに貼り付け、そのファイルをirbでrequireして実行しましょう。

# 例

# irb
# require '/Users/shibatadaiki/work_shiba/full_stack/sample.rb'
# （↑のパスは、自動販売機ファイルが入っているパスを指定する）

# 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
# vm = VendingMachine.new

class Drink
  attr_reader :name, :price

  def self.cola# Drink.cola で cola(インスタンス)を返す
    self.new :cola, 120
  end

  def self.redbull# Drink.redbull で redbull(インスタンス)を返す
    self.new :redbull, 200
  end

  def self.water# Drink.water で water(インスタンス)を返す
    self.new :water, 100
  end

  def initialize(name, price)
    @name = name
    @price = price
  end

end


class VendingMachine
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze

  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
    @sale_amount = 0
    @drinks = []
    5.times {@drinks.push(Drink.cola)}
  end

  def stocks #vm.stocks　在庫(インスタンス自体)表示
    @drinks
  end

  def stock_info #vm.stock_info　在庫リスト表示
    cola_count = 0
    redbull_count = 0
    water_count = 0
    @drinks.each do |element|
      cola_count += 1 if element.name == :cola
      redbull_count += 1 if element.name == :redbull
      water_count += 1 if element.name == :water
    end
    @stock_list = {cola: cola_count, redbull: redbull_count, water: water_count}
  end

  def store(drink) #vm.store Drink.cola
    @drinks.push(drink)
  end

  def sales_count #vm.sales_count で売上額表示
    @sale_amount
  end

#  def query_cola
#    if (@slot_money >= Drink.cola.price) && (@stock_list[:cola] >= 1)
#      puts "投入金額#{@slot_money}円、在庫#{@stock_list[:cola]}、購入できます。"
#    else
#      puts "投入金額#{@slot_money}円、在庫#{@stock_list[:cola]}、購入できません。"
#    end
#  end

  def which_can_buy #vm.which_can_buyで購入可能リスト表示
    if (@slot_money >= Drink.cola.price) && (@stock_list[:cola] >= 1)
      puts "#{Drink.cola.name}の価格#{Drink.cola.price}円、投入金額#{@slot_money}円、在庫#{@stock_list[:cola]}、購入できます。"
    end
    if (@slot_money >= Drink.redbull.price) && (@stock_list[:redbull] >= 1)
      puts "#{Drink.redbull.name}の価格#{Drink.redbull.price}円、投入金額#{@slot_money}円、在庫#{@stock_list[:redbull]}、購入できます。"
    end
    if (@slot_money >= Drink.water.price) && (@stock_list[:water] >= 1)
      puts "#{Drink.water.name}の価格#{Drink.water.price}円、投入金額#{@slot_money}円、在庫#{@stock_list[:water]}、購入できます。"
    end
  end

  def purchase_cola #vm.purchase_colaでcola購入
    if (@slot_money >= Drink.cola.price) && (@stock_list[:cola] >= 1)
      puts "投入金額#{@slot_money}円、在庫#{@stock_list[:cola]}、1本購入しました。"
      @sale_amount += Drink.cola.price
      @slot_money -= Drink.cola.price
      @stock_list[:cola] -= 1
#      @drinks.delete_at(0)  #一品目用
      @drinks.delete_if do |element|
        element.name == :cola #条件式
      end
      @stock_list[:cola].times {@drinks.push(Drink.cola)}
    else
      puts "投入金額#{@slot_money}円、在庫#{@stock_list[:cola]}、購入できません。"
    end
  end

  def purchase_redbull
    if (@slot_money >= Drink.redbull.price) && (@stock_list[:redbull] >= 1)
      puts "投入金額#{@slot_money}円、在庫#{@stock_list[:redbull]}、1本購入しました。"
      @sale_amount += Drink.redbull.price
      @slot_money -= Drink.redbull.price
      @stock_list[:redbull] -= 1
#      @drinks.delete_at(0)  #一品目用
      @drinks.delete_if do |element|
        element.name == :redbull #条件式
      end
      @stock_list[:redbull].times {@drinks.push(Drink.redbull)}
    else
      puts "投入金額#{@slot_money}円、在庫#{@stock_list[:redbull]}、購入できません。"
    end
  end

  def purchase_water
    if (@slot_money >= Drink.water.price) && (@stock_list[:water] >= 1)
      puts "投入金額#{@slot_money}円、在庫#{@stock_list[:water]}、1本購入しました。"
      @sale_amount += Drink.water.price
      @slot_money -= Drink.water.price
      @stock_list[:water] -= 1
#      @drinks.delete_at(0)  #一品目用
      @drinks.delete_if do |element|
        element.name == :water #条件式
      end
      @stock_list[:water].times {@drinks.push(Drink.water)}
    else
      puts "投入金額#{@slot_money}円、在庫#{@stock_list[:water]}、購入できません。"
    end
  end

  # 投入金額の総計を取得できる。
  def current_slot_money #vm.current_slot_moneyで入金額表示
    # 自動販売機に入っているお金を表示する
    @slot_money
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money) #vm.slot_money(100)で入金
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return false unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money # vm.return_moneyで返金
    # 返すお金の金額を表示する
    puts "#{@slot_money}円のお返しです。"
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end
end

class FiveTimesStore < VendingMachine
  def store(drink) #vm=FiveTimesStore.newして、vm.store Drink.cola
    super
    super
    super
    super
    super
  end
end

class PurchaseAndReturn < VendingMachine
  def purchase_cola_and_return #vm=PurchaseAndReturn.newして、vm.purchase_cola_and_return
    purchase_cola
    return_money
  end

  def purchase_redbull_and_return
    purchase_redbull
    return_money
  end

  def purchase_water_and_return
    purchase_water
    return_money
  end

end
