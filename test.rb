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
    @all = {cola: Drink.cola, redbull: Drink.redbull, water: Drink.water}
    @drinks = []
    5.times {@drinks.push(Drink.cola)}
  end

  def stock_info #vm.stock_info　在庫リスト表示
    # all = {cola: Drink.cola, redbull: Drink.redbull, water: Drink.water}
    @stock_list = @all.map{|key, value| [key, @drinks.find_all{|i| i.name==value.name}.size] }.to_h
  end

  def store(drink, quantity = 1) #vm.store Drink.cola, 5
    quantity.times {@drinks.push(drink)}
  end

  def sales_count #vm.sales_count で売上額表示
    @sale_amount
  end

  def which_can_buy #vm.which_can_buyで購入可能リスト表示
    stock_info
    # all = {cola: Drink.cola, redbull: Drink.redbull, water: Drink.water}
    @all.each do |key, value|
      if (@slot_money >= value.price) && (@stock_list[key] >= 1)
        puts "#{value.name}の価格#{value.price}円、投入金額#{@slot_money}円、在庫#{@stock_list[key]}、購入できます。"
      else
        puts "#{value.name}は購入できません"
      end
    end
  end

  def purchase(drink) #vm.purchase Drink.colaでcola購入
    stock_info
    if (@slot_money >= drink.price) && (@stock_list[drink.name] >=1 )
      puts "投入金額#{@slot_money}円、在庫#{@stock_list[drink.name]}、1本購入しました。"
      @sale_amount += drink.price
      @slot_money -= drink.price
      @stock_list[drink.name] -= 1
      @drinks.delete_at(@drinks.find_index{|element| element.name == drink.name})
    else
      puts "投入金額#{@slot_money}円、在庫#{@stock_list[drink.name]}、購入できません。"
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

class PurchaseAndReturn < VendingMachine
  def purchase(drink) #vm=PurchaseAndReturn.newして、vm.purchase Drink.cola
    super
    return_money
  end
end