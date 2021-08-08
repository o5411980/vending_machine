# TDD Boot Camp 大阪 3.0/課題
詳細  
http://devtesting.jp/tddbc/?TDDBC%E5%A4%A7%E9%98%AA3.0%2F%E8%AA%B2%E9%A1%8C
### for example
- 自販機をスタート
```
machine = VendingMachine.new
```

- お金を投入するするとき
```
machine.insert_money(100)
machine.insert_money(500)
```

- 購入操作
```
machine.purchase
```

- 投入金額合計
```
machine.total
```

- 売り上げ金額の表示
```
machine.sale_amount
```

- 在庫確認
```
machine.stock_info
```

- ドリンク補充
  - 新規でドリンクを補充するとき
  ```
  machine.store(Drink.new("ドリンク名", 値段), 個数)
  ```
  - 既存のドリンクを補充するとき
  ```
  machine.store(Drink.cola, 5)
  machine.store(Drink.redbull, 5)
  machine.store(Drink.water, 5)
  ```
