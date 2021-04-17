class Admin::HomesController < ApplicationController
  def top
    # ページ(10個指定)の数を超えると次のページに表示する
    @orders = Order.page(params[:page]).reverse_order
  end 
end
