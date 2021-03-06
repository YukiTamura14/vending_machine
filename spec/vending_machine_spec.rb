require 'spec_helper'
require_relative '../vending_machine'

RSpec.describe VendingMachine do
  let(:vm) { VendingMachine.new }

  describe '#insert' do
    it 'お金を投入できる' do
      expect(vm.insert(500)).to eq(500)
    end
  end

  describe '#total' do
    it 'お金の投入は複数回できる' do
      expect(vm.insert(100)).to eq(100)
      expect(vm.insert(500)).to eq(600)
      expect(vm.insert(1000)).to eq(1600)

      expect(vm.total).to eq(1600)
    end

    it '10円硬貨、50円硬貨、100円硬貨、500円硬貨、1000円札以外が投入された場合はそのままお釣りとして出力する' do
      expect(vm.insert(1)).to eq(1)
      expect(vm.insert(5)).to eq(5)
      expect(vm.insert(5000)).to eq(5000)
      expect(vm.insert(10000)).to eq(10000)
      expect(vm.total).to eq(0)
    end
  end

  describe '#payback' do
    it '払い戻しを行うと投入したお金の合計をお釣りとして出力する' do
      vm.insert(1000)
      expect(vm.payback).to eq (1000)
    end
  end

  describe '#purchasable_drinks' do
    it '投入したお金で購入できる飲み物を取得できる' do
      vm.store
      expect(vm.purchasable_drinks).to eq [nil, nil, nil]
      vm.insert(10)
      vm.insert(10)
      vm.insert(100)
      expect(vm.purchasable_drinks).to eq ["cola", nil, "water"]
    end

    it '購入できるかどうか在庫を確認できる' do
      vm.store
      5.times do
        vm.insert(10)
        vm.insert(10)
        vm.insert(100)
        vm.purchase('cola')
      end

      vm.insert(10)
      vm.insert(10)
      vm.insert(100)
      expect(vm.purchasable_drinks).to eq [nil, nil, "water"]
    end
  end

  describe '#purchase' do
    it '購入すると売上が増える' do
      vm.store
      expect(vm.sale_amount).to eq 0
      vm.insert(10)
      vm.insert(10)
      vm.insert(100)

      vm.purchase('cola')
      expect(vm.sale_amount).to eq 120
    end

    it 'お金が足りないと購入できない' do
      vm.store
      vm.insert(100)
      expect(vm.purchase('cola')).to eq nil
    end

    it '在庫がないと購入できない' do
      vm.store
      5.times do
        vm.insert(10)
        vm.insert(10)
        vm.insert(100)
        vm.purchase('cola')
      end

      vm.insert(10)
      vm.insert(10)
      vm.insert(100)
      expect(vm.purchase('cola')).to eq nil
    end

    it '投入したお金が飲み物の値段以上のときに購入すると、お釣り（投入したお金と飲み物の値段の差額）を出力する' do
      vm.store
      vm.insert(500)
      expect(vm.purchase('cola')).to eq(380)
    end
  end
end
