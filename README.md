# VendingMachine

## 使い方
1.irbを起動
`$ irb`

2.プログラムを読み込む
<br>
`> require './vending_machine(20200313).rb'`
<br>
または
<br>
`> load './vending_machine(20200313).rb'`

3.自動販売機を初期化
`> vm = VendingMachine.new`

4.飲み物を補充する
`> vm.store`

5.補充されている飲み物の情報を表示する
`> vm.drinks`

6.お金を投入する
<br>
`> vm.insert(100)`
<br>
`> #10円硬貨、50円硬貨、100円硬貨、500円硬貨、1000円札がご利用いただけます`
<br>
`> #なお、払い戻しは vm.payback になります`

7.投入したお金の合計を表示
`> vm.total`

8.購入できる飲み物を表示
`> vm.purchasable?`

9.飲み物を購入
<br>
`> vm.purchase('cola')`
<br>
`> #コーラ(cola)、レッドブル(Red Bull)、水(water)が購入いただけます`
<br>
`> #おつりが返却されます`

10.売上の合計を表示
`> vm.sale_amount`
