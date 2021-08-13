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

  def stocks
    @drinks
  end

  def stock_info #vm.stock_info
    cola_count = 0
    @drinks.each do |element|
      cola_count += 1 if element.name == :cola
    end
    @stock_list = {cola: cola_count}
  end

  def store(drink) #vm.store Drink.cola
    @drinks.push(drink)
  end

  def sales_count
    @sale_amount
  end

#  def query_cola
#    if (@slot_money >= Drink.cola.price) && (@stock_list[:cola] >= 1)
#      puts "投入金額#{@slot_money}円、在庫#{@stock_list[:cola]}、購入できます。"
#    else
#      puts "投入金額#{@slot_money}円、在庫#{@stock_list[:cola]}、購入できません。"
#    end
#  end

  def purchase_cola
    if (@slot_money >= Drink.cola.price) && (@stock_list[:cola] >= 1)
      puts "投入金額#{@slot_money}円、在庫#{@stock_list[:cola]}、購入できます。"
      @sale_amount += Drink.cola.price
      @slot_money -= Drink.cola.price
      @stock_list[:cola] -= 1
      @drinks.delete_at(0)
    else
      puts "投入金額#{@slot_money}円、在庫#{@stock_list[:cola]}、購入できません。"
    end
  end


  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @slot_money
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return false unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts @slot_money
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end
end
