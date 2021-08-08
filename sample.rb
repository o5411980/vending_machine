# irb
# require './sample.rb'
# vm = VendingMachine.new
#注意　呼び出す順番によってインスタンス変数 @stock_listがカラになり、その状態で@stock_listを使うとエラーになる。次に、vm.stocks実行。
#　　　購入したら、vm.stocks と vm.stock_info を実行。


class Drink
  attr_reader :name, :price

  def self.cola
    self.new 120, :cola
  end

  def initialize price, name
    @name = name
    @price = price
  end

end


class VendingMachine
  attr_reader :total, :sale_amount, :drink_stocks
  MONEY = [10, 50, 100, 500, 1000].freeze

  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
    @sale_amount = 0
    @drinks = []
    5.times {@drinks.push(Drink.cola)}
  end

  def stocks #vm.stocksで在庫(@drinks)を出力
    @drinks
  end

  def sales_count #vm.sales_countで 売上表示
    @sale_amount
  end

  def stock_info #vm.stock_infoで在庫リストを出力
    cola_count = 0
    @drinks.each do |element|
      cola_count += 1 if element.name == :cola
    end
#    cola_count = @drinks.select { |element| element.name == :cola }.count
    @stock_list = {cola: cola_count}
  end

  def store(drink) #vm.store Drink.colaで colaを１本補充
    @drinks.push(drink)
  end

  def query_cola #vm.query_colaで価格、在庫、投入金額、購入可否を表示
#    Drink.cola
#    @stock_list[:cola] = 0
    @can_buy = false
#    @stock_list #メソッド呼出順によりインスタンス変数@stock_listがカラになるので、検証用
    if (@slot_money >= Drink.cola.price) && (@stock_list[:cola] > 1)
      @can_buy = true
    end
    puts "price:#{Drink.cola.price}, stock:#{@stock_list[:cola]}, slot_money:#{@slot_money}, can_buy?:#{@can_buy}"
  end

  def purchase_cola #vm.purchase_cola で colaを１本購入
    if @can_buy
      puts "1 cola purchased"
      @sale_amount += Drink.cola.price
      @slot_money -= Drink.cola.price
      @stock_list[:cola] -= 1 #在庫減少はこのだけコードではダメ。 在庫は@drinks, @stock_listはただの集計表。@drinksを操作する。
      @drinks.delete_if do |element| #delete_if do end　で　@stocksから name= :colaを全削除。
        element.name == :cola
      end
#      @drinks.delete_at 0 #一番簡単な在庫減少のコード。ただし、1品目の時しか使えない。
      @stock_list[:cola].times {@drinks.push(Drink.cola)} #4行上で更新した数量だけcolaを@stocksに充填
    else
      return "price:#{Drink.cola.price}, stock:#{@stock_list[:cola]}, slot_money:#{@slot_money}, can_buy?:#{@can_buy}"
    end
  end

  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @slot_money
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money) #vm.slot_money(money)で "money"を自販機に投入
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    puts "#{money}円 返却" unless MONEY.include?(money)
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
