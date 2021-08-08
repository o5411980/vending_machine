require "./drink"
require "./category"
# require "./vending_machine.rb"
# TODO: ソニックガーデンさんコードレビュー
# ファイル名にハイフンは使わない。アンスコ（_）かキャメルケースで
# require "./VendingMachine.rb"

class VendingMachine
  # 利用可能なお金
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze
  attr_reader :total, :sale_amount, :stocks, :unsdn

  # 初期設定
  # TODO: ソニックガーデンさんコードレビュー
  # 初期設定はもう少しシンプルに
  def initialize
    @total = 0
    @sale_amount = 0
    @stocks = []
    @drinks = []
    5.times { @drinks.push(Drink.cola) }
    c = Category.new(@drinks)
    @stocks.push(c) if c.validate_class && c.validate_unique
    @unsdn = []
  end

  # 購入操作
  def purchase
    drink_menu
    input = gets
    if input == "x\n"
      pay_back
    elsif input.to_i >= 0 && input.to_i < @stocks.length
      @int = input.to_i
      purchase_select(@int) unless @stocks[@int].drinks.empty?
    end
  end

  # 払い戻し操作
  def pay_back
    puts "#{total}円のお返しです。"
    @total = 0
  end

  # ドリンク選択
  # TODO: ソニックガーデンさんコードレビュー
  # 在庫の管理は配列のindexではなく、ハッシュのkeyでした方がいいかも
  def purchase_select(int)#@intにすると引数ではなくインスタンス変数を参照しに行ってしまいエラーになる。
    drink = @stocks[int].drinks.first#重複する記述を変数に代入
    if @stocks[int].drinks.length > 0 && drink.price <= @total
      @total -= drink.price
      @sale_amount += drink.price
      puts "#{drink.name}を購入しました。"
      # 削除後、再代入しないと初回購入時は削除されるけど次回購入時以降は削除されなくなる。
      @stocks[int].drinks = @stocks[int].drinks.drop(1)
    else
      puts "#{drink.price - @total}円不足しています。お金を投入して下さい。"
    end
  end

  # ドリンクメニュー
  def drink_menu
    puts "投入金額 #{total}円"
    puts "-----------------------------------------"
    unless @stocks.empty?
      @stocks.each_with_index do |stock, idx|
        drink = stock.drinks.first#重複する記述を変数に代入
        unstock_drink(drink.name) unless stock.drinks.empty?
        puts "[#{idx}]:#{drink.name}　#{drink.price}円" unless stock.drinks.empty?
        puts "[#{idx}]:#{@unsdn[idx]}は、ただいま品切れ中です。" if stock.drinks.empty?
      end
    end
    puts "-----------------------------------------"
    puts "[x]払い戻し"
    puts ""
    puts "商品番号を選択してください。"
  end

  # ドリンクメニュー画面に表示する品切れ中のドリンク名を保管するための配列
  def unstock_drink(name)
    @unsdn << name unless @unsdn.include?(name)
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  def insert_money(money)
    # 利用可能なお金か判定
    if AVAILABLE_MONEY.include?(money)
      # 投入金額の総計を取得できる。
      @total += money
      puts "投入金額の合計は#{@total}円です。"
    else
      # 想定外のもの（硬貨：１円玉、５円玉。お札：千円札以外のお札）が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
      puts "#{money}円は使用できません。"
    end
  end

  # ドリンク補充操作
  def store(drink, num)
    stocks_delete
    @unsdn.clear#clearを使うと配列の中身に要素があっても空にしてしまう
    @drinks = []
    num.times { @drinks.push(drink) }
    c = Category.new(@drinks)
    @stocks.push(c) if c.validate_class && c.validate_unique
  end

  # 空の配列を削除
  def stocks_delete
    @stocks.delete_if { |n| n.drinks.empty? }
  end

  # 在庫確認
  def stock_info
    @new_stocks = []
    @stocks.each do |stock|
      # 在庫を保有している配列を@new_stocksに格納
      @new_stocks << stock unless stock.drinks.empty?
    end

    unless @new_stocks.empty?
      @new_stocks.each_with_index do |stock, idx|
        drink = stock.drinks.first
        puts "名前:#{drink.name} \n 値段:#{drink.price} \n 在庫:#{stock_count(drink.name, idx)}"
      end
    else
      puts "在庫切れです。"
    end
  end

  # ドリンク毎の在庫を計算
  def stock_count(name, idx)
    @new_stocks[idx].drinks.select { |drink| drink.name == name }.count
  end
end
